class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
  has_many :comments
  has_many :followers
  has_many :following
  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
  has_secure_password
end