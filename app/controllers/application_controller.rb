class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  #404file 띄우기
  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
