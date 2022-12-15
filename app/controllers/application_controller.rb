class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError do |e|
    flash[:error] = e.message

    if session[:current_fullpath] == session[:return_to]
      redirect_to(root_path)
    else
      redirect_to(session[:return_to] || root_path)
    end
  end

  def return_location
    session[:return_to] = request.fullpath if request.get?
    session[:current_fullpath] = request.fullpath
  end
end
