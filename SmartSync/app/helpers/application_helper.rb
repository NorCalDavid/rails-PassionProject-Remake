module ApplicationHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user_id
    session[:user_id]
  end

  def current_user
    return nil if current_user_id.blank?
    begin
      @current_user ||= User.find(session[:user_id])
    rescue
      logout
    end
  end
end
