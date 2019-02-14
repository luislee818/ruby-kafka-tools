# KafkaTools

A simple library for monitoring Kafka topics. Uses [`ruby-kafka`](https://github.com/zendesk/ruby-kafka) under the covers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-kafka-tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-kafka-tools

## Usage

```ruby
require 'ruby-kafka-tools'
require 'json'

BROKER = 'broker url'
TOPIC = 'topic name'

monitor = KafkaTools::TopicMonitor.new

filter = -> (key, value) { JSON.parse(value)['prop'] == 'target' }

monitor.subscribe(broker: BROKER, topic: TOPIC, filter: filter) do |message|
  puts message.value
end

trap("TERM") { monitor.stop }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby-kafka-tools.
