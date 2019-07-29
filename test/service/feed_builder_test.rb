require 'test_helper'

class FeedBuilderTest < Minitest::Test
  def service
    Service::FeedBuilder
  end

  SAMPLE_CONFIG_PATH =
    File.expand_path(File.join(File.dirname(__FILE__), './feeds.yml')).freeze

  def test_sample_config_exists
    message = "#{SAMPLE_CONFIG_PATH} should exist"
    assert(File.exist?(SAMPLE_CONFIG_PATH), message)
  end

  def test_find
    feeds = Service::FeedsList.call(SAMPLE_CONFIG_PATH)
    feeds.each do |feed|
      feed_name = feed[:name]
      conf = ->(feed_name) { feeds.find { |feed| feed[:name] == feed_name } }
      result = service.call(feed_name, conf)
      expected = Feed.find_by(name: feed_name)
      assert_equal(result, expected)
    end
  end
end