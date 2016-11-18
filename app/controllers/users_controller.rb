class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Successfully created account"
      create_session(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Updated profile'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def correct_user
    if @user != current_user
      flash[:error] = "You don't have permission for that"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end