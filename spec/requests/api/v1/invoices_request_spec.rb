require 'rails_helper'

describe "Invoices API" do
  context "GET /invoices" do
    it "sends a list of invoices" do
      Customer.create!(first_name: "Bob", last_name: "Smith")
      create(:merchant)
      create_list(:invoice, 3)

      get '/api/v1/invoices.json'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end

    it "sends one invoice" do
      Customer.create!(id: 1, first_name: "Bill", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv["status"]).to eq(invoice.status)
      expect(inv["merchant_id"]).to eq(invoice.merchant_id)
    end

    it "can find one item" do
      Customer.create!(id: 1, first_name: "Bill", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")
      invoice = create(:invoice)

      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv["status"]).to eq(invoice.status)
      expect(inv.class).to eq(Hash)
    end

    it "can find multiple items" do
      Customer.create!(id: 1, first_name: "Bill", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find_all?customer_id=1&merchant_id=1"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv.count).to eq(3)

      get "/api/v1/invoices/find_all?status=Shipped"

      expect(inv.count).to eq(3)
    end

    it "can find a random item" do
      Customer.create!(id: 1, first_name: "Bill", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")
      invoices = create_list(:invoice, 5)

      get "/api/v1/invoices/random.json"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv.class).to be(Hash)
    end

    it "returns a collection of associated transactions" do
      invoice = create(:invoice)
      transaction_1 = Transaction.create!(invoice_id: 1, credit_card_number: "1234123412341234", credit_card_expiration_date: "2012-03-23", result: "failed")
      transaction_2 = Transaction.create!(invoice_id: 1, credit_card_number: "1234123412341234", credit_card_expiration_date: "2012-03-23", result: "success")
      transaction_3 = Transaction.create!(invoice_id: 2, credit_card_number: "1234123412341234", credit_card_expiration_date: "2012-03-23", result: "failed")

      get "/api/v1/invoices/#{invoice.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end

    it "returns a collection of associated invoice_items" do
      invoice = create(:invoice)
      InvoiceItem.create!(id: 1, invoice_id: 1, item_id: 1, quantity: 1, unit_price: 100)
      InvoiceItem.create!(id: 2, invoice_id: 1, item_id: 2, quantity: 2, unit_price: 150)
      InvoiceItem.create!(id: 3, invoice_id: 1, item_id: 3, quantity: 3, unit_price: 200)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end

    it "returns a collection of associated items" do
      invoice = create(:invoice)
      Merchant.create!(id: 1, name: "Bob")
      Item.create!(name: "item_1", description: "something", unit_price: 200, merchant_id: 1)
      Item.create!(name: "item_2", description: "something", unit_price: 200, merchant_id: 1)
      InvoiceItem.create!(id: 1, invoice_id: 1, item_id: 1, quantity: 1, unit_price: 100)
      InvoiceItem.create!(id: 2, invoice_id: 1, item_id: 2, quantity: 2, unit_price: 150)


      get "/api/v1/invoices/#{invoice.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end

    it "returns an associated customer" do
      invoice = Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")


      get "/api/v1/invoices/#{invoice.id}/customer"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer[:first_name]).to eq("Bob")
    end

    it "returns an associated merchant" do
      invoice = Invoice.create!(id: 1, customer_id: 1, merchant_id: 1, status: "shipped")
      Customer.create!(id: 1, first_name: "Bob", last_name: "Smith")
      Merchant.create!(id: 1, name: "Bob")


      get "/api/v1/invoices/#{invoice.id}/merchant"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant[:name]).to eq("Bob")
    end
  end
end
