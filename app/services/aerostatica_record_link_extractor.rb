class AerostaticaRecordLinkExtractor
  PATTERN = %r{https://aerostatica\.ru/music/\w+\.mp3}.freeze

  def self.call(content)
    content.scan(PATTERN).first
  end
end
