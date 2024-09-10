class BookViewService
  def initialize(book)
    @book = book
  end

  def increment_view
    $redis.incr(cache_key)
  end

  def get_view_count
    $redis.get(cache_key).to_i
  end

  private

  def cache_key
    "book:#{@book.id}:views:#{Time.current.to_date}"
  end
end
