require 'rails_helper'

RSpec.describe CommentersController, type: :controller do

  describe "GET #top_ten" do
    it "returns http success" do
      get :top_ten
      expect(response).to have_http_status(:success)
    end
  end

end
