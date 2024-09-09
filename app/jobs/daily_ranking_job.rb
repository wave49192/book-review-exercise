class DailyRankingJob < ApplicationJob
  queue_as :default

  def perform
    today = Date.today

    rank = Rank.find_or_create_by(date: today)

    books_with_views = []

    Book.find_each do |book|
      view_count = BookViewService.new(book).get_view_count

      if view_count > 0
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
