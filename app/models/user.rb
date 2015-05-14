class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy 
  has_many :favorites, dependent: :destroy 

  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true,
                   format:  /\A\S+@\S+\z/,
                   uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       format: /\A[A-Z0-9]+\z/i,
                       uniqueness: { case_sensitive: false }

  scope :by_name, -> { order('name') }

  scope :not_admins, -> { by_name.where(admin: false) }

  before_save :format

  def format
    self.username = username.downcase
    self.email = email.downcase
  end

  def gravatar_id
      Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by_username(email_or_username)
    user && user.authenticate(password)
  end
end
