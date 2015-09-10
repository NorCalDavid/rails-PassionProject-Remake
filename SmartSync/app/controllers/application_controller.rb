class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :current_user_id

  def current_user
    return nil if session[:user_id].blank?
    begin
      @current_user ||= User.find(session[:user_id])
    rescue
      logout
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user_id
    session[:user_id]
  end

  private

  def set_current_user(user)
    session[:user_id] = user.id
    @current_user = user
  end


  def alert_string(num)
    num.times { ap ("*" * 50).to_s, :color => {:string => :red} }
  end

  def console_alert(args = {})
    alert_types = [[:title, :red], [:message, :green], [:parameters, :blue]]

    alert_types.each do |alert_type|
      alert_string(1)
      ap "#{alert_type[0]}: #{args[alert_type[0]]}", :color => {:string => alert_type[1]}
      alert_string(1)
    end

    puts
  end

end
