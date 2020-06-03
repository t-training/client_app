require 'rails_helper'

RSpec.describe "TopPages", type: :system do
  before { visit root_path }
  subject { page }
  describe `root` do
    it `is root page` do
      expect(page).to have_current_path root_path
    end
  end
  
  describe 'outside login' do
    describe '遷移前' do
      before do
        visit root_path
        click_link "Log in"
      end
      
      scenario 'URL付きでリダイレクトされること' do
        expect(page).to have_current_path("https://afternoon-anchorage-19414.herokuapp.com/login/", ignore_query: true)
        query_hash = Rack::Utils.parse_nested_query(URI.parse(current_url).query)
        expect(query_hash['url']).to_not be_empty
      end
    end

    describe '遷移後' do
      # TODO: user_idとtokenはランダム生成できると良さげ
      let(:user_id) { "1" }
      let(:token) { "aaaaa" }
      
      before do
        uri = URI(root_url)
        uri.query = URI.encode_www_form({user_id: user_id, token: token})
        visit uri
      end
      scenario "user_idとtokenがURLに含まれていること" do
        query_hash = Rack::Utils.parse_nested_query(URI.parse(current_url).query)
        expect(query_hash['user_id']).to_not be_empty
        expect(query_hash['token']).to_not be_empty
      end
      scenario "cookiesに保存されていること" do
        cookies = page.driver.browser.manage.all_cookies
        token_cookie = cookies.find { |c| c[:name] == "access_token" }
        id_cookie = cookies.find { |c| c[:name] == "user_id" }
        expect(token_cookie[:value]).to eq token
        # FIXME: id_cookieは署名付きクッキーなので合わない
        expect(id_cookie[:value]).to eq user_id
      end
    end
  end
end
