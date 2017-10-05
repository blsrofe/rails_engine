require 'rails_helper'

RSpec.describe "Customer Relationship API" do
  context "GET /customers/:id/invoices" do
    it "sends a collection of associated invoices" do
      customer = create(:customer, :with_invoices)

      get "/api/v1/customers/#{customer.id}/invoices"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(3)
    end
  end
end
