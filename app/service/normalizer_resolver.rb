module Service
  class NormalizerResolver
    extend Dry::Initializer

    param :feed

    def self.call(feed)
      new(feed).call
    end

    def call
      matching_normalizer || raise("no matching normalizer for [#{feed.name}]")
    end

    private

    def matching_normalizer
      available_names.each do |name|
        safe_name = name.to_s.gsub(/-/, '_')
        return "normalizers/#{safe_name}_normalizer".classify.constantize
      rescue
        next
      end
    end

    def available_names
      [
        feed.normalizer,
        feed.processor,
        feed.name
      ]
    end
  end
end