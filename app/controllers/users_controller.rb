class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = @current_user

    redirect_to new_session_url if @user.email.nil? && @user.first_name.nil? && @user.last_name.nil?
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user].merge!({:is_from_user_form => true}))
      redirect_to user_url(@user)
    else
      render "edit"
    end
  end
end