class BookViewService
  def initialize(book)
    @book = book
  end

  def increment_view
    key = cache_key
    count = Rails.cache.read(key).to_i || 0
    Rails.cache.write(key, count + 1, expires_in: 24.hours)
  end

  def get_view_count
    Rails.cache.read(cache_key).to_i || 0
  end

  private

  def cache_key
    "book:#{@book.id}:views:#{Date.today}"
  end
end
