module Normalizers
  class Base
    include Callee

    param :entity
    param :feed
    option :logger, optional: true, default: -> { Rails.logger }

    def call
      valid? ? ::Success.new(payload) : ::Failure.new(validation_errors)
    rescue StandardError => e
      logger.error(e)
      # TODO: Persist error
      ::Failure.new("normalization error: #{e.message}")
    end

    protected

    def link
      nil
    end

    def published_at
      nil
    end

    def text
      nil
    end

    def attachments
      []
    end

    def comments
      []
    end

    SEPARATOR = ' - '.freeze

    def separator
      SEPARATOR
    end

    def valid?
      validation_errors.blank?
    end

    def validation_errors
      []
    end

    def options
      feed.try(:options) || {}
    end

    private

    def payload
      {
        'link' => link,
        'published_at' => published_at,
        'text' => text,
        'attachments' => attachments,
        'comments' => comments
      }.freeze
    end
  end
end
