module UsersHelper

def signed_in?
  if User.all != nil
    session[:user_id] != nil
  end
end

def current_user
  if session[:user_id] != nil
    @current_user = Affiliate.find(session[:affiliate_id])
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
