class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = @current_user

    redirect_to new_session_url if @user.email.nil? && @user.first_name.nil? && @user.last_name.nil?
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to user_url(@user)
    else
      render "new"
    end
  end
end