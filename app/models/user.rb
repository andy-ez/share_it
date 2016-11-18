class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :cast_votes, class_name: 'Vote', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, on: :new
  validates :password, allow_blank: true, confirmation: true, on: :update
end