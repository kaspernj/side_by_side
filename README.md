# SideBySide

## Installation

Run multiple commands concurrently and output each run as it is running in order in an optimal way.

```ruby
gem "side_by_side"
```

Or install globally:

```bash
gem install side_by_side
```

## Usage

Try to order the commands with the fastest command first for showing the output the most natural way (it will output the first command as it is running,
but the second command will not output anything until the first command is done even though the second command will be running simultanious with the first).

```bash
side_by_side "yarn scsslint" "yarn eslint" "bundle exec rubocop"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaspernj/side_by_side.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
