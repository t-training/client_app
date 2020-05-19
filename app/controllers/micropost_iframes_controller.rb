require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index 
    uri = URI.parse("https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/#{params[:id]}/microposts")
    response = Net::HTTP.get_response(uri)
    if (response.code == "200")
      @microposts = JSON.parse(response.body)
      render partial: 'microposts'
    else
      @error = JSON.parse(response.body)
      render partial: 'error_microposts'
    end
  end
end
