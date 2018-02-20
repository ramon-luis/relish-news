class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :topics, optional: true

  # validate that favorite has a rank
  validates :rank, presense: true

end
