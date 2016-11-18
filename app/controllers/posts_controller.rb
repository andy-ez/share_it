class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :correct_user, only: [:edit]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post successfully created.'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated.'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    vote = Vote.new(vote: params[:direction] == 'up', voteable: @post, user: current_user)
    if vote.save
      flash[:notice] = 'Voted!'
    else
      flash[:error] = "You can only vote on a post once"
    end
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    if @post.user != current_user
      flash[:error] = "You don't have permission to do that"
      redirect_to posts_path
    end
  end
end
