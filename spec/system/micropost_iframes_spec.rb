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
  
end
