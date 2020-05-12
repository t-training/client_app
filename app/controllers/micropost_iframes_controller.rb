require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def show_microposts
    uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=140010')
    microposts_json = Net::HTTP.get(uri)
    @microposts_hash = JSON.parse(microposts_json)
    render :layout => nil
  end
end
