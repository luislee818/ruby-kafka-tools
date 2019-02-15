require 'kafka'

module KafkaTools
  class TopicMonitor
    def subscribe(broker:, topic:, start_from_beginning: false, filter: method(:always_true), consumer_group: 'ruby-kafka-tools')
      kafka = Kafka.new([broker])

      @consumer = kafka.consumer(group_id: consumer_group)
      @consumer.subscribe(topic, start_from_beginning: start_from_beginning)

      @consumer.each_message do |message|
        yield message if filter.call(message.key, message.value)
      end
    end

    def stop
      @consumer.stop if @consumer
    end

    private
    def always_true(k, v)
      true
    end
  end
end
