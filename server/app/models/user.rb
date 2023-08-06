class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_many :followers
  has_many :following
  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
  has_secure_password
end