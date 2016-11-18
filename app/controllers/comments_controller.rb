class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit!)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment submitted'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.new(vote: params[:direction] == 'up', voteable: comment, user: current_user)
    if vote.save
      flash[:notice] = 'Voted!'
    else
      flash[:error] = "You can only vote on a comment once."
    end
    redirect_to :back
  end

end