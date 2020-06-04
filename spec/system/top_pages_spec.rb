require 'rails_helper'

RSpec.describe "TopPages", type: :system do
  before { visit root_path }
  subject { page }
  describe `root` do
    it `is root page` do
      expect(page).to have_current_path root_path
    end
  end
  
  describe 'リモートログイン' do
    describe '遷移前' do
      before do
        visit root_path
        click_link "Log in"
      end
      
      it 'URL付きでリダイレクトされること' do
        expect(page).to have_current_path("https://afternoon-anchorage-19414.herokuapp.com/login/", ignore_query: true)
        query_hash = Rack::Utils.parse_nested_query(URI.parse(current_url).query)
        expect(query_hash['url']).to_not be_empty
      end
    end

    describe '遷移後' do
      let(:user_id) { Faker::Number.number(:digits => 4).to_s }
      let(:token) { SecureRandom.urlsafe_base64 }
      
      before do
        uri = URI(root_url)
        uri.query = URI.encode_www_form({user_id: user_id, token: token})
        visit uri
      end
      
      it "user_idとtokenがURLに含まれていること" do
        query_hash = Rack::Utils.parse_nested_query(URI.parse(current_url).query)
        expect(query_hash['user_id']).to_not be_empty
        expect(query_hash['token']).to_not be_empty
      end
      it "cookiesに保存されていること" do
        cookies = page.driver.browser.manage.all_cookies
        token_cookie = cookies.find { |c| c[:name] == "access_token" }
        id_cookie = cookies.find { |c| c[:name] == "user_id" }
        expect(token_cookie[:value]).to eq token
        signed_id_cookie = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
        signed_id_cookie.signed[:user_id] = user_id
        expect(id_cookie[:value]).to eq signed_id_cookie[:user_id]
      end
    end
  end
end
