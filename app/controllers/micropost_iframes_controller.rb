require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index 
    uri = URI.parse("https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/#{params[:id]}/microposts")
    begin
      response = Net::HTTP.get_response(uri)
      if(response["Content-Type"].include?("application/json"))
        if(response.code == "200")
          @microposts = JSON.parse(response.body)
          @profile = "https://afternoon-anchorage-19414.herokuapp.com/users/#{params[:id]}"
          render 'microposts'
        else
          @errors = JSON.parse(response.body)
          render 'error_microposts_api_json'
        end
      else
        if(response.code == "200")
          render 'response_not_json'
        else
          @status = response.code
          render 'error_microposts_api'
        end
      end
    rescue => exception
      @errors = exception
      render 'error_access'
    end
    
  end
end
