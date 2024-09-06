# == Schema Information
#
# Table name: book_ranks
#
#  id         :bigint           not null, primary key
#  view       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  order_id   :integer
#  rank_id    :bigint           not null
#
# Indexes
#
#  index_book_ranks_on_book_id              (book_id)
#  index_book_ranks_on_book_id_and_rank_id  (book_id,rank_id) UNIQUE
#  index_book_ranks_on_rank_id              (rank_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (rank_id => ranks.id)
#
require 'rails_helper'

RSpec.describe BookRank, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
