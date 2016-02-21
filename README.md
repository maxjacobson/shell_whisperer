# shell whisperer

[![Build Status](https://travis-ci.org/maxjacobson/shell_whisperer.svg)](https://travis-ci.org/maxjacobson/shell_whisperer)

This is a very small library to provide a wrapper around Ruby's backtick thing,
where you can run shell commands.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shell_whisperer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shell_whisperer

## Usage

Happy path (the command succeeds and outputs something):

```ruby
ShellWhisperer.run "ls" #=> "README.md\n"
ShellWhisperer.run "cat README.md" #=> "Content of README.md\n"
```

Sad path (the command fails and prints an error):

```ruby
begin
  ShellWhisperer.run "cat README.dm"
rescue ShellWhisperer::CommandFailed => e
  e #=> #<ShellWhisperer::CommandFailed: Attempted to run "cat README.dm" but the shell reported error: "cat: README.dm: No such file or directory" and exited with exit code 1.>
  e.original_command #=> "cat README.dm"
  e.original_message #=> "cat README.dm: No such file or directory \n"
  e.exit_code #=> 1
end
```

The goal is that you have a nice way of capturing output of a command while also
having a nice way of knowing why something failed, if it failed.

Here's a caveat:

```ruby
ShellWhisperer.run("cat README.md | wc -l").to_i #=> 69
ShellWhisperer.run("cat README.dm | wc -l").to_i #=> 0
```

What!? Shouldn't the second one have failed, because the `README.dm` file does
not exist? Well, maybe, but it pipes its output to `wc`, and `wc` succeeds, so
ShellWhisperer thinks the whole thing succeeded. For this reason, it might make
more sense to write this example like:

```ruby
ShellWhisperer.run("cat README.dm").each_line.count
```

Which will fail in the desired way.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To 
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/maxjacobson/shell_whisperer. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
