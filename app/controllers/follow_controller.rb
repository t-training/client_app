require 'net/http'
require 'uri'
require 'json'

class FollowController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create 
    #REVIEW: 未テスト
    uri = URI.parse("https://afternoon-anchorage-19414.herokuapp.com/api/v1/relationships")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    
    request_params = { user_id: cookies.permanent.signed[:user_id], 
               followed_id: params[:followed_id] }
    
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(request_params)
    req.initialize_http_header({ "Content-Type" => "application/json"})
    req.initialize_http_header({ "Authorization" => "Token #{cookies.permanent[:access_token]}"})
    
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
