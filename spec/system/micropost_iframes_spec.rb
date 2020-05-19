require 'rails_helper'

RSpec.describe "MicropostIframes", type: :system do
  subject { page }

  context `exist user` do
    before { visit "/microposts?id=1" }
    it `returns user_name title` do
      is_expected.to have_selector("h2", text: "Example Userのpost")
    end
    it `returns microposts` do
      is_expected.to have_selector(".content")
    end
  end
  
  context `not exist user` do
    before { visit "/microposts?id=999" }
    it `returns error title` do
      is_expected.to have_selector("h2", text: "エラー")
    end
    it `returns error message` do
      is_expected.to have_content("Validation Failed")
    end
  end
  
end
