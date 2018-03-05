class User < ApplicationRecord

  attr_accessor :remember_token
  before_save   :downcase_email

  has_many :favorites, :dependent => :destroy
  has_many :topics, through: :favorites

  # always downcase emails before saving
  before_save { self.email.downcase! }

  # validate that names exist with max length of 50
  validates :name, presence: true, length: { maximum: 50 }

  # check for valid email format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validate that email exists with max length and unique to db
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

  # validate password - allow_nil for updates to model
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns tre if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_token, nil)
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

end
