require 'rails_helper'

describe "Invoices API" do
  context "GET /invoices" do
    it "sends a list of invoices" do
      create_list(:invoice, 3)

      get '/api/v1/invoices.json'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end

    it "sends one invoice" do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      inv = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(inv["status"]).to eq(invoice.status)
      expect(inv["merchant_id"]).to eq(invoice.merchant_id)
    end

    it "can find one item" do
      invoice = create(:invoice)
      binding.pry
      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
    
      inv = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(inv["status"]).to eq(invoice.status)
      expect(inv.class).to eq(Hash)
    end

    it "can find multiple items" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices/find_all?customer_id=1&merchant_id=1"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv.count).to eq(3)

      get "/api/v1/invoices/find_all?status=Shipped"

      expect(inv.count).to eq(3)
    end

    it "can find a random item" do
      invoices = create_list(:invoice, 5)

      get "/api/v1/invoices/random.json"

      inv = JSON.parse(response.body)

      expect(response).to be_success
      expect(inv.class).to be(Hash)
    end
  end
end
