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

    #TODO: responseのログイン状態を見て、ログインしていなければログインに飛ばしたりメッセージ表示したり
    #TODO: responseのフォロー状態を見て、メッセージを表示
  end
end
