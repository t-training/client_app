require 'rails_helper'

RSpec.describe "MicropostIframes", type: :request do
  describe `#index` do
    subject { response.body }

    it `returns json` do
      get microposts_path id:1
      is_expected.to include "Example User"
    end

    context `not exist user` do
      before { get microposts_path id:999 }
      it `returns error title` do
        is_expected.to include "エラー"
      end
      it `returns error message` do
        is_expected.to include "Validation Failed"
      end
    end
  end
end
