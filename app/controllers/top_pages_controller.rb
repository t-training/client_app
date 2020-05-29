class TopPagesController < ApplicationController
  def index
    @url = "https://afternoon-anchorage-19414.herokuapp.com/login/?url=#{root_url}"
  end
end
