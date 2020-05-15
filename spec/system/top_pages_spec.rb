require 'rails_helper'

RSpec.describe "TopPages", type: :system do
  before { visit root_path }
  subject { page }
  describe `root` do
    it `is root page` do
      expect(page).to have_current_path root_path
    end
  end

  describe `microposts` do
    let!(:iframe) { find('iframe') }
    context `MicropostAPI` do
      it `returns user_icon` do
        within_frame(iframe) do
          is_expected.to have_selector(".gravatar")
        end
      end
      it `returns user_name` do
        within_frame(iframe) do
          is_expected.to have_selector(".user")
        end
      end
      it `returns user_post` do
        within_frame(iframe) do
          is_expected.to have_selector(".content")
        end
      end
      it `returns post time` do
        within_frame(iframe) do
          is_expected.to have_selector(".timestamp")
        end
      end
    end
  end
end
