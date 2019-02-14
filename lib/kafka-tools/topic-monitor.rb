require 'kafka'

module KafkaTools
  class TopicMonitor
    def subscribe(broker:, topic:, start_from_beginning: false, filter: method(:always_true))
      @kafka = Kafka.new([broker])

      @kafka.each_message(topic: topic, start_from_beginning: start_from_beginning, min_bytes: 1, max_wait_time: 1) do |message|
        yield message if filter.call(message.key, message.value)
      end
    end

    def stop
      @kafka.close if @kafka
    end

    private
    def always_true(k, v)
      true
    end
  end
end
