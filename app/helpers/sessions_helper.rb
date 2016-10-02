module SessionsHelper
  def login(user)
    cookies.permanent.signed[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])  
    if (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user
        login user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    cookies.delete(:user_id)
    @current_user = nil
  end
end
