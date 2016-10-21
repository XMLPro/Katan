module SessionsHelper
  def login(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:user_secret_token] = user.secret_token
  end

  def current_user
    unless @current_user
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.secret_token == cookies.signed[:user_secret_token]
        login user
        @current_user = user
      end
    end
    @current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    cookies.delete(:user_id)
    @current_user = nil
  end
end
