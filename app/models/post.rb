class Post < ActiveRecord::Base
  before_destroy :destroy_coupon_codes

  belongs_to :user
  has_many :comments
  has_many :votes, as: :voteable
  has_many :post_categories
  has_many :categories, through: :post_categories
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true

  

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.size - up_votes
  end

  def total_votes
    up_votes - down_votes
  end

  private

  def destroy_comments
    self.comments.delete_all   
  end

end