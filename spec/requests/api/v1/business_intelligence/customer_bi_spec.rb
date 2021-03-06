require 'rails_helper'

describe "Customers API" do
  context "GET /customers" do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      customer = Customer.create!(id: 1, first_name: "Jerry", last_name: "Smith")
      merchant_1 = Merchant.create!(id: 1, name: "Larry")
      merchant_2 = Merchant.create!(id: 2, name: "Moe")
      merchant_3 = Merchant.create!(id: 3, name: "Curly")
      merchant_4 = Merchant.create!(id: 4, name: "Bob")
      invoice = Invoice.create!(id: 1, customer_id: 1, merchant_id: 4, status: "shipped")
      invoice_2 = Invoice.create!(id: 2, customer_id: 1, merchant_id: 3, status: "shipped")
      invoice_3 = Invoice.create!(id: 3, customer_id: 1, merchant_id: 3, status: "shipped")
      invoice_4 = Invoice.create!(id: 4, customer_id: 1, merchant_id: 4, status: "shipped")
      transaction = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_2 = Transaction.create!(id: 2, invoice_id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "failed")
      transaction_3 = Transaction.create!(id: 3, invoice_id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
      transaction_4 = Transaction.create!(id: 4, invoice_id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      merchant = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant["name"]).to eq("Bob")
    end
  end
end
