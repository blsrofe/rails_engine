require 'rails_helper'

RSpec.describe "Customer Relationship API" do
  context "GET /customers/:id/invoices" do
    it "sends a collection of associated invoices" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
    end
  end

  context "GET /customers/:id/transactions" do
    it "sends a collection of associated transactions" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transactions = create_list(:transaction, 3, invoice_id: invoice.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
    end
  end
end
