require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe `root` do
    before { visit root_path }
    it `is root page` do
      expect(page).to have_current_path root_path
    end
  end
end
