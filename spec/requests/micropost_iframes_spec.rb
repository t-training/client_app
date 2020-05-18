require 'rails_helper'

RSpec.describe "MicropostIframes", type: :request do
  describe `#index` do
    subject { response.body }

    it `returns json` do
      get microposts_path
      is_expected.to include "Example User"
    end
  end
end
