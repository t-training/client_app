module FollowHelper
  def update_request(uri, user_id, followed_id, token)
    request_params = { followed_id: followed_id }
    
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(request_params)
    req.initialize_http_header({ "Content-Type" => "application/json"})
    req.initialize_http_header({ "Authorization" => "Token #{token}"})
    req
  end
end