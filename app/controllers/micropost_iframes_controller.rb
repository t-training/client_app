require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index
=begin 
    uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=140010')
    microposts_json = Net::HTTP.get(uri)
    @microposts_hash = JSON.parse(microposts_json)
=end

    File.open("#{Rails.public_path}/json/microposts.json") do |j|
      @microposts_hash = JSON.load(j)
    end

    render :layout => nil
  end
end
