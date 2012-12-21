class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_p3p_headers
  before_filter :login_required
  before_filter :refresh_session

  def current_user
    @current_user ||= begin
      if session[:expires] && session[:expires] != 0 && session[:expires].to_i < Time.zone.now.to_i
        session[:uid] = nil
      elsif session[:uid]
        user = User.find_or_create_by_uid(session[:uid])
        user
      end
    end
  end

  def login_required
    if current_user.nil?
      redirect_to new_session_url
    end
  end

  def set_p3p_headers
    headers['P3P'] = 'policyref="http://' + request.host + '/w3c/p3p.xml", CP= "CAO PSA OUR"'
  end

  def refresh_session
    render("sessions/redirection") and return if session[:expires] && session[:expires] != 0 && session[:expires].to_i < Time.zone.now.to_i
  end

  def rescue_fb_errors
    begin
      yield
    rescue Koala::Facebook::APIError => e
      if e.fb_error_type == "HTTP 500" || e.fb_error_code == 190
        render("sessions/redirection") and return
      else
        raise "Facebook Error - type: #{e.fb_error_type} - code: #{e.fb_error_code} - message: #{e.fb_error_message}"
      end
    rescue Errno::ETIMEDOUT => e
      render("sessions/redirection") and return
    end
  end
end
