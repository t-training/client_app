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
    before do
      visit root_path
      click_link "Log in"
      fill_in "Email", with: "example@railstutorial.org"
      fill_in "Password", with: "foobar"
      click_button "Log in"
    end
    
    scenario "リダイレクトURLが指定したURLであること" do
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
    scenario "user_idとtokenがURLに含まれていること" do
      query_hash = Rack::Utils.parse_nested_query(URI.parse(current_url).query)
      expect(query_hash['user_id']).to_not be_empty
      expect(query_hash['token']).to_not be_empty
    end
  end
end
