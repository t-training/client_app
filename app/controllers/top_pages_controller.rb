class TopPagesController < ApplicationController
  def index
    if(params[:user_id] && params[:token]) 
      cookies.permanent.signed[:user_id] = params[:user_id]
      cookies.permanent[:access_token] = params[:token]
    end
    
    @url = "https://afternoon-anchorage-19414.herokuapp.com/login/?url=#{root_url}"
  end
end
