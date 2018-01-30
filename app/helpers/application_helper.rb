module ApplicationHelper

def signed_in?
  !current_user.nil?
end

def current_user
  if cookies[:auth_token] != nil
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
end

def flash_class(level)
  case level
    when "info" then "alert alert-info"
    when "success" then "alert alert-success"
    when "errors" then "alert alert-warning"
    when "alert" then "alert alert-danger"
  end
end
end
