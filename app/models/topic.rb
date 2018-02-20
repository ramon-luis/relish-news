class Topic < ApplicationRecord

  has_many :favorites
  has_many :users, through: :favorites

  # validate that topic has a unique name, route, and url_param
  validates :name, uniqueness: {case_sensitive: false}
  validates :route, uniqueness: {case_sensitive: false}
  validates :url_param, uniqueness: {case_sensitive: false}

end
