class DailyRankingJob < ApplicationJob
  queue_as :default

  def perform
    today = Time.current.to_date
    rank = Rank.find_or_create_by(date: today)
    books_with_views = []

    redis = $redis
    book_keys = redis.keys("book:*:views:#{today}")

    book_keys.each do |key|
      book_id = key.split(":")[1]
      view_count = redis.get(key).to_i

      if view_count > 0
        book = Book.find(book_id)
        book_rank = BookRank.find_or_initialize_by(book: book, rank: rank)
        book_rank.update(view: view_count)
        books_with_views << book_rank
      end
    end

    assign_rankings(books_with_views)
  end

  private

  def assign_rankings(book_ranks)
    sorted_book_ranks = book_ranks.sort_by { |book_rank| -book_rank.view }

    sorted_book_ranks.each_with_index do |book_rank, index|
      book_rank.update(order_id: index + 1)
    end
  end
end
