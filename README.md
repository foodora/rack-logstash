# Rack::Logstash

Rack::Logstash offers a simple to file request logger supporting the logstash format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-logstash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-logstash

## Usage

Simply include Rack::Logstash::Logger as a Rack middleware:

```ruby
use Rack::Logstash::Logger
```

By default requests will be logged to `log/access.log`. You can change this file by passing the file path as an argument:

```ruby
use Rack::Logstash::Logger, '/var/log/rack/requests.log'
```

To include additional fields to the log output,

```ruby
use Rack::Logstash::Logger, {
        app_name: 'my.awesome.app'
    }
```

Of course, both arguments can be used in combination:

```ruby
use Rack::Logstash::Logger, '/var/log/rack/requests.log', {
        app_name: 'my.awesome.app'
    }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/foodora/rack-logstash.

