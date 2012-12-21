class SessionsController < ApplicationController
  skip_before_filter :login_required
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_filter :refresh_session
  around_filter :rescue_fb_errors, :only => [:create]

  def new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    if params[:signed_request]
      response = Koala::Facebook::OAuth.new(create_session_url).parse_signed_request(params[:signed_request])
      if response["page"].blank?
        render(:redirection) && return
      end
      if response['oauth_token']
        session[:expires] = response['expires'] == 0 ? 0 : Time.now.to_i + response['expires'].to_i
        session[:uid] = response['user_id']

        user = User.find_or_create_by_uid(response['user_id'])
        user.token = response['oauth_token'] if response['oauth_token']
        user.expire = response['expires'] if response['expires'] 
        user.save

        @current_user = user
      else
        session[:uid] = nil
      end
    end

    if session[:uid]
      current_user
      redirect_to @current_user.email.nil? ? edit_user_url(@current_user) : user_url(@current_user)
    else
      redirect_to new_session_url
    end
  end
end
