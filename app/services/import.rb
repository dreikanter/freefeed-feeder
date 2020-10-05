class Import
  include Callee

  param :feed
  option :logger, optional: true, default: -> { Rails.logger }

  def call
    @started_at = Time.now.utc
    generate_new_posts
  ensure
    update_feed_timestamps
    save_data_point
  end

  private

  attr_reader :started_at

  def generate_new_posts
    entities.each do |entity|
      next unless entity
      logger.info("---> creating new post [#{entity[:uid]}]")
      post = find_or_create_new_post(entity)
      post.update(status: post_status(entity))
      next unless post.ready?
      logger.info("---> scheduling post; uid: [#{entity[:uid]}]")
      PushJob.perform_later(post)
    end
  end

  def find_or_create_new_post(entity)
    existing_post = Post.find_by(feed_id: feed_id, uid: entity[:uid])
    existing_post || Post.create!(entity.merge(feed_id: feed_id))
  end

  def feed_id
    feed.id
  end

  def feed_name
    feed.name
  end

  def post_status(entity)
    entity[:validation_errors].none? ? PostStatus.ready : PostStatus.ignored
  end

  def save_data_point
    logger.info("---> updating feed history [#{feed_name}]")

    CreateDataPoint.call(
      :pull,
      feed_name: feed_name,
      posts_count: entities.count,
      errors_count: errors_count,
      duration: Time.new.utc - started_at,
      status: UpdateStatus.success
    )
  end

  def errors_count
    entities.count do |entity|
      entity.nil? || post_status(entity) != PostStatus.ready
    end
  end

  def entities
    @entities ||= Pull.call(feed)
  end

  def update_feed_timestamps
    logger.info("---> updating feed timestamps [#{feed_name}]")

    feed.update(
      last_post_created_at: last_post_created_at,
      refreshed_at: started_at
    )
  end

  def last_post_created_at
    feed.posts.maximum(:created_at)
  end
end
