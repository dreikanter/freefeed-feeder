class WordpressNormalizer < BaseNormalizer
  protected

  def link
    content.url
  end

  def published_at
    content.published
  end

  def text
    [content.title, link].join(separator)
  end

  def attachments
    [image_url]
  end

  def comments
    [description]
  end

  private

  def image_url
    Html.first_image_url(content.content)
  end

  def description
    excerpt = Html.squeeze(content.content)
    Html.comment_excerpt(excerpt)
  end
end
