require "time"
module V1
  module Entities
    class BookEntity < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :release, as: :release, format_with: ->(date) { date.strftime("%Y-%m-%d") if date }
      expose :created_at, as: :created_at, format_with: ->(datetime) { datetime.strftime("%Y-%m-%dT%H:%M:%S") if datetime }
      expose :updated_at, as: :updated_at, format_with: ->(datetime) { datetime.strftime("%Y-%m-%dT%H:%M:%S") if datetime }
    end
  end
end
