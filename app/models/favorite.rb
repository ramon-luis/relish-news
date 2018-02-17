class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :topics, optional: true
end
