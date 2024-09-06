module V1
  module Entities
    class ReviewEntity < Grape::Entity
      expose :id
      expose :comment
      expose :star
      expose :created_at, as: :created_at, format_with: ->(datetime) { datetime.strftime("%Y-%m-%dT%H:%M:%S") if datetime }
      expose :updated_at, as: :updated_at, format_with: ->(datetime) { datetime.strftime("%Y-%m-%dT%H:%M:%S") if datetime }
    end
  end
end
