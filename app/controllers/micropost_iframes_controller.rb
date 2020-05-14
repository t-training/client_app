require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index 
    uri = URI.parse('https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/2/microposts')
    response = Net::HTTP.get(uri)
    @microposts = JSON.parse(response)
    render layout: nil
  end
end
