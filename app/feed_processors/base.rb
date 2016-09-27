module FeedProcessors
  class Base
    def self.process(source)
      send(:new, source).send(:recent_entities)
    end

    attr_reader :source
    attr_reader :feed_name

    private

    def initialize(source)
      @source = source
    end

    def recent_entities
      (limit > 0) ? entities.take(max_entities) : entities
    end

    def limit
      ENV['MAX_ENTITIES_PER_FEED'].to_i
    end

    def entities
      fail NotImplementedError, "#{self.class.name}##{__method__} is not implemented"
    end
  end
end