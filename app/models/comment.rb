class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable
  validates :body, presence: true

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.size - up_votes
  end

  def total_votes
    up_votes - down_votes
  end
end