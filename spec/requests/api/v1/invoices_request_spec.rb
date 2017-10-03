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

      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
    
      #inv = JSON.parse(response.body)
      expect(response).to be_success
    end
  end
end
