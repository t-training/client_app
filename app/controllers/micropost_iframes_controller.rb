require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index 
    uri = URI.parse("https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/1/microposts")
    response = Net::HTTP.get_response(uri)
    mime_type = response["Content-Type"]
    status = response.code
    if(mime_type.include?("application/json"))
      if(status == "200")
        @microposts = JSON.parse(response.body)
        render partial: 'microposts'
      else
        @errors = JSON.parse(response.body)
        render layout: nil, partial: 'error_microposts_api_json'
      end
    else
      if(status == "200")
        render layout: nil, partial: 'response_not_json'
      end
      @status = status
      render layout: nil, partial: 'error_microposts_api'
    end
  end
end
