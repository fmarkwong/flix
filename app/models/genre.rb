class Genre < ActiveRecord::Base
  has_many :characterizations, dependent: :destroy

  has_many :movies, through: :characterizations

  validate :name, presence: true, uniqueness: true

end
