require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index 
    uri = URI.parse('https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/2/get_microposts')
    microposts_json = Net::HTTP.get(uri)
    @microposts_hash = JSON.parse(microposts_json)
    render :layout => nil
  end
end
