require 'rails_helper'

describe "Merchant Relationships API" do
  context "GET /merchants/:id" do
    it "sends items associated with that merchant" do
      merchant = create(:merchant, :with_items)

      get "/api/v1/merchants/#{merchant.id}/items"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
      expect(json.class).to eq(Array)
    end
  end
end
