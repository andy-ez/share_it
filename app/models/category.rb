class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  has_many :votes, as: :voteable
  validates :name, uniqueness: { case_sensitive: false }, presence: true
end