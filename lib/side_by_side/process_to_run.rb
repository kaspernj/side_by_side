require "pty"

class SideBySide::ProcessToRun
  attr_reader :command, :exit_status, :monitor, :on_output_callback, :output, :pid, :start_time, :stop_time, :thread

  def initialize(command:)
    @command = command
    @output = []
    @monitor = Monitor.new
  end

  def join
    while !thread
      puts "Pass - waiting for thread"
      Thread.pass
    end

    thread.join
  end

  def on_output(&blk)
    puts "Setting on output for: #{command}"
    @on_output_callback = blk
  end

  def output!(out)
    type = out.fetch(:type)

    if type == :stdout
      $stdout << out.fetch(:output)
    elsif type == :stderr
      $stderr << out.fetch(:output)
    else
      raise "Unknown type: #{type}"
    end
  end

  def run_async
    @thread = Thread.new do
      @start_time = Time.new
      stderr_reader, stderr_writer = IO.pipe

      PTY.spawn(command, err: stderr_writer.fileno) do |stdout, stdin, pid|
        @pid = pid

        puts "Command running: #{command} - #{stdout.class.name}"

        stdout_reader_thread = Thread.new do
          begin
            stdout.each_char do |chunk|
              monitor.synchronize do
                out = {type: :stdout, output: chunk}
                output << out
                on_output_callback&.call(out)
              end
            end
          rescue Errno::EIO => e
            # Process done
          ensure
            status = Process::Status.wait(@pid, 0)

            @exit_status = status.exitstatus
            stderr_writer.close
          end
        end

        stderr_reader_thread = Thread.new do
          stderr_reader.each_char do |chunk|
            monitor.synchronize do
              out = {type: :stderr, output: chunk}
              output << out
              on_output_callback&.call(out)
            end
          end
        end

        stdout_reader_thread.join
        stderr_reader_thread.join

        @stop_time = Time.new
      end
    end
  end

  def seconds
    @stop_time.to_f - @start_time.to_f
  end
end
