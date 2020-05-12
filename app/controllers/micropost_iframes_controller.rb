require 'net/http'
require 'uri'
require 'json'

class MicropostIframesController < ApplicationController
  def index
    uri = URI.parse('')
    microposts_json = Net::HTTP.get(uri)
    @microposts_hash = JSON.parse(microposts_json)
=begin 
    File.open("#{Rails.public_path}/json/microposts.json") do |j|
      @microposts_hash = JSON.load(j)
    end
=end
    render :layout => nil
  end
end
