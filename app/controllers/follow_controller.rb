require 'net/http'
require 'uri'
require 'json'

class FollowController < ApplicationController
  protect_from_forgery :except => [:create]
  include FollowHelper
  
  def create 
    #REVIEW: 未テスト
    uri = URI.parse("https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/#{cookies.permanent.signed[:user_id]}/relationships")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    req = update_request(uri, params[:followed_id], cookies.permanent[:access_token])

    begin
      response = http.request(req)
      
      response_json = JSON.parse(response.body)
      
      if(response.code == "200")
        if(!reponse_json["followed"])
          flash[:info] = "既にフォローしています"
        elsif(response_json["followed"]) 
          flash[:success] = "フォローできました"
        end
      else
        uri = URI("https://afternoon-anchorage-19414.herokuapp.com/login/")
        uri.query = URI.encode_www_form({url: root_url})
        redirect_to uri.to_s
      end
    rescue
      flash[:danger] = "アクセスエラー"
      redirect_to root_url
    end
  end
end
