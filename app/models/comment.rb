class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :user_id, uniqueness: { scope: :movie_id, message: "You've already commented on that movie" }
  validates :body, presence: true, length: { minimum: 1 }
end
