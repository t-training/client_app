class FollowController < ApplicationController
  protect_from_forgery except: :create

  def create 
    #REVIEW: 未テスト
    response = RestClient.post "https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/#{cookies.permanent.signed[:user_id]}/relationships",
                    {followed_id: params[:followed_id]}, 
                    {Authorization: "Token #{cookies.permanent[:access_token]}"}    
    response_json = JSON.parse(response.body)
    print response.code
    if(response.code == 200)
      if(!response_json["followed"])
        flash[:info] = "既にフォローしています"
        redirect_to root_url
      elsif(response_json["followed"])
        flash[:success] = "フォローできました"
        redirect_to root_url
      end
    end
  rescue RestClient::NotFound
    uri = URI("https://afternoon-anchorage-19414.herokuapp.com/login/")
    uri.query = URI.encode_www_form({url: root_url})
    redirect_to uri.to_s
    
  rescue RestClient::Unauthorized
    uri = URI("https://afternoon-anchorage-19414.herokuapp.com/login/")
    uri.query = URI.encode_www_form({url: root_url})
    redirect_to uri.to_s
    
  rescue
    flash[:danger] = "アクセスエラー"
    redirect_to root_url
  end
end
