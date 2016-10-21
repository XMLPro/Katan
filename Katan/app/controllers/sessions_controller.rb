class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.create(name: params[:session][:name], secret_token: SecureRandom.hex(8))
    if user
      login(user)
      if current_user
        redirect_to root_url
      else
        redirect_to login_url , alert: 'ログインに失敗しました。英数字でお願いします。'
      end
    end
  end

  def destroy
    current_user.destroy
    log_out
    redirect_to login_url
  end
end
