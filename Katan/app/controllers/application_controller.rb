class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include TopsHelper
  include ApplicationHelper

  def current_user
    view_context.current_user
  end

  def hello
    render text: "hello"
  end
end
