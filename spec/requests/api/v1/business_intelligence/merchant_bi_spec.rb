require 'rails_helper'

RSpec.describe "Merchant BI Endpoints" do
  context "single merchant endpoints" do
    it "sends favorite customers by merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      expect(response).to be_success
    end
  end
end
