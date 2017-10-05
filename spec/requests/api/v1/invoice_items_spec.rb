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
      expect(json["unit_price"]).to eq("100.00")
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

    it "can find multiple items" do
      invoice_items = create_list(:invoice_item, 3)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_items[1].quantity}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
      expect(json.class).to be(Array)
    end

    it "can find a random item" do
      invoice_items = create_list(:invoice_item, 5)

      get "/api/v1/invoice_items/random.json"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.class).to be(Hash)
    end

    it "returns the associated invoice" do
      Merchant.create!(id: 1, name: "Bob")
      Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      Item.create!(id: 1, name: "item_1", description: "something", unit_price: 200, merchant_id: 1)
      Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      invoice_item = InvoiceItem.create!(id: 1, invoice_id: 1, item_id: 1, quantity: 1, unit_price: 100)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("shipped")
    end

    it "returns the associated item" do
      Merchant.create!(id: 1, name: "Bob")
      Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      Item.create!(id: 1, name: "item_1", description: "something", unit_price: 200, merchant_id: 1)
      Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      invoice_item = InvoiceItem.create!(id: 1, invoice_id: 1, item_id: 1, quantity: 1, unit_price: 100)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["description"]).to eq("something")
    end
  end
end
