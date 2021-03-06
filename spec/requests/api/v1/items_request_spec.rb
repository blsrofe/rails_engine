require 'rails_helper'

RSpec.describe "Items API" do
  context "GET /items" do
    it "sends a list of items" do
      merchant = create(:merchant)
      create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items.json"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end

    it "sends one item" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(item.name)
      expect(json["description"]).to eq(item.description)
    end

    it "can find one item" do
      merchant = create(:merchant)
      item = create_list(:item, 3, unit_price: 1006, merchant_id: merchant.id)

      get "/api/v1/items/find?name=#{item[1].name}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(item[1].name)
      expect(json["unit_price"]).to eq("10.06")

      get "/api/v1/items/find?description=#{item[0].description}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq(item[0].description)
      expect(json["unit_price"]).to eq("10.06")

      get "/api/v1/items/find?unit_price=#{item[2].unit_price}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq(item[0].description)
      expect(json["name"]).to eq(item[0].name)
    end

    it "can find multiple items" do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=#{items[1].merchant_id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(5)
      expect(json.class).to be(Array)
    end

    it "can find a random item" do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant_id: merchant.id)

      get "/api/v1/items/random.json"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.class).to be(Hash)
    end

    it "returns a collection of associated invoice items" do
      Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")
      Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      item = Item.create!(id: 1, name: "item_1", description: "something", unit_price: 200, merchant_id: 1)
      InvoiceItem.create!(id: 1, invoice_id: 1, item_id: 1, quantity: 1, unit_price: 100)
      InvoiceItem.create!(id: 2, invoice_id: 1, item_id: 1, quantity: 2, unit_price: 150)

      get "/api/v1/items/#{item.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
    end

    it "returns the associated merchant" do
      Merchant.create!(id: 1, name: "Bob")
      item = Item.create!(id: 1, name: "item_1", description: "something", unit_price: 200, merchant_id: 1)

      get "/api/v1/items/#{item.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Bob")
    end

    it "returns top item instances ranked by total number sold" do
      customer = Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      merchant_1 = Merchant.create!(id: 1, name: "Larry")
      merchant_2 = Merchant.create!(id: 2, name: "Moe")
      merchant_3 = Merchant.create!(id: 3, name: "Curly")
      merchant_4 = Merchant.create!(id: 4, name: "Bob")
      item = Item.create!(id: 1, name: "thing", description: "something", unit_price: 200, merchant_id: 1)
      item_2 = Item.create!(id: 2, name: "thing_2", description: "something", unit_price: 250, merchant_id: 2)
      item_3 = Item.create!(id: 3, name: "thing_3", description: "something", unit_price: 100, merchant_id: 3)
      item_4 = Item.create!(id: 4, name: "thing_4", description: "something", unit_price: 150, merchant_id: 4)
      invoice = Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      invoice_2 = Invoice.create!(id: 2, customer_id: 1, merchant_id: 2, status: "shipped")
      invoice_3 = Invoice.create!(id: 3, customer_id: 1, merchant_id: 3, status: "shipped")
      invoice_4 = Invoice.create!(id: 4, customer_id: 1, merchant_id: 4, status: "shipped")
      transaction = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_2 = Transaction.create!(id: 2, invoice_id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "failed")
      transaction_3 = Transaction.create!(id: 3, invoice_id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_4 = Transaction.create!(id: 4, invoice_id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      invoice_item = InvoiceItem.create!(id: 1, item_id: 4, invoice_id: 4, quantity: 3, unit_price: 200)
      invoice_item_2 = InvoiceItem.create!(id: 2, item_id: 2, invoice_id: 1, quantity: 1, unit_price: 100)
      invoice_item_3 = InvoiceItem.create!(id: 3, item_id: 2, invoice_id: 2, quantity: 5, unit_price: 100)
      invoice_item_4 = InvoiceItem.create!(id: 4, item_id: 3, invoice_id: 2, quantity: 1, unit_price: 300)
      invoice_item_5 = InvoiceItem.create!(id: 5, item_id: 1, invoice_id: 3, quantity: 2, unit_price: 300)

      get "/api/v1/items/most_items?quantity=3"
      items = JSON.parse(response.body)
      expect(response).to be_success
      expect(items.count).to eq(3)
      expect(items.first["name"]).to eq("thing_4")
      expect(items.last["name"]).to eq("thing_2")
    end

    it "returns the date with the most sales for a given item" do
      customer = Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      merchant_1 = Merchant.create!(id: 1, name: "Larry")
      item = Item.create!(id: 1, name: "thing", description: "something", unit_price: 200, merchant_id: 1)
      invoice = Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped", created_at: "2012-03-16 11:55:05")
      invoice_2 = Invoice.create!(id: 2, customer_id: 1, merchant_id: 1, status: "shipped", created_at: "2012-03-17 11:55:05")
      invoice_3 = Invoice.create!(id: 3, customer_id: 1, merchant_id: 1, status: "shipped", created_at: "2012-03-18 11:55:05")
      transaction = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_2 = Transaction.create!(id: 2, invoice_id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_3 = Transaction.create!(id: 3, invoice_id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      invoice_item_2 = InvoiceItem.create!(id: 1, item_id: 1, invoice_id: 1, quantity: 1, unit_price: 100)
      invoice_item_3 = InvoiceItem.create!(id: 2, item_id: 1, invoice_id: 2, quantity: 5, unit_price: 100)
      invoice_item_5 = InvoiceItem.create!(id: 4, item_id: 1, invoice_id: 3, quantity: 2, unit_price: 100)

      get "/api/v1/items/#{item.id}/best_day"
      day = JSON.parse(response.body)
      expect(response).to be_success
      expect(day["best_day"]).to eq("2012-03-17T11:55:05.000Z")
    end
  end
end
