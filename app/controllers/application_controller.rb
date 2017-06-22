class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
  	render template: "static_pages/home"
  end
end
