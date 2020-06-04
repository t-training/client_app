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

    response = http.request(req)
    
    response_json = JSON.parse(response.body)
    
    if(!response_json["is_logged"])
      uri = URI("https://afternoon-anchorage-19414.herokuapp.com/login/")
      uri.query = URI.encode_www_form({url: root_url})
      redirect_to uri.to_s
    elsif(!reponse_json["followed"])
      #TODO: 既にフォローしていたことを伝えるメッセージ表示
    elsif(response_json["followed"]) 
      #TODO: フォローできたことを伝えるメッセージ表示
    end
  end
end
