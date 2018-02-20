class Topic < ApplicationRecord

  has_many :favorites
  has_many :users, through: :favorites

  # validate that topic has a unique name, route, and url_param
  validates :name, uniqueness: true
  validates :route, uniqueness: true
  validates :url_param, uniqueness: true

end
