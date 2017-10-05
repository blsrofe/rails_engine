require 'rails_helper'

RSpec.describe "Invoice Items API" do
  context "Get /invoice_items" do
    it "sends a list invoice item" do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items.json'

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
    end

    it "sends one invoice item" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      json = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(invoice_item.unit_price).to eq(json["unit_price"])
      expect(invoice_item.item_id).to eq(json["item_id"])
    end

    it "can find one invoice item" do
      invoice_item = create(:invoice_item)
      
      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

      json = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(invoice_item.quantity).to eq(json["quantity"])
      expect(invoice_item.invoice_id).to eq(json["invoice_id"])
    end
  end
end
