require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "MicropostIframes", type: :request do
  describe `#index` do
    subject { response.body }
    before do
      WebMock.stub_request(:get, "https://afternoon-anchorage-19414.herokuapp.com/api/v1/users/2/microposts").to_return(
        body: File.read("#{Rails.root}/test/fixtures/user1_microposts.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })
    end

    it `returns json` do
      get microposts_path
      is_expected.to include "Example User"
    end
  end
end
