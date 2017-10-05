require 'rails_helper'

describe "Merchant Relationships API" do
  context "GET /merchants/:id" do
    it "sends items associated with that merchant" do
      merchant = create(:merchant, :with_items)
      merchant_2 = create(:merchant, :with_items)

      get "/api/v1/merchants/#{merchant.id}/items"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
      expect(json[1]["name"]).to eq(merchant.items[1].name)

      get "/api/v1/merchants/#{merchant_2.id}/items"

      json = JSON.parse(response.body)
      
      expect(json.count).to eq(3)
      expect(json[0]["description"]).to eq(merchant_2.items[0].description)
    end

    it "sends invoices associated with that merchant" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json.count).to eq(3)
      expect(merchant.invoices[2].status).to eq(json[2]["status"])
    end
  end
end
