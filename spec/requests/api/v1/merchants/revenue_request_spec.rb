require 'rails_helper'

describe "Merchants API" do
  it "finds total revenue for merchant" do
    customer = Customer.create!(first_name: "Bob", last_name: "Smith")
    merchant = Merchant.create!(name: "Larry")
    item = Item.create!(name: "thing", description: "something", unit_price: 200, merchant_id: 1)
    item_2 = Item.create!(name: "thing_2", description: "something", unit_price: 100, merchant_id: 1)
    item_3 = Item.create!(name: "thing_3", description: "something", unit_price: 100, merchant_id: 1)
    invoice = Invoice.create!(customer_id: 1, merchant_id: 1, status: "shipped")
    invoice_2 = Invoice.create!(customer_id: 1, merchant_id: 1, status: "shipped")
    invoice_3 = Invoice.create!(customer_id: 1, merchant_id: 1, status: "shipped")
    transaction = Transaction.create!(invoice_id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
    transaction_2 = Transaction.create!(invoice_id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "failed")
    transaction_3 = Transaction.create!(invoice_id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "2012-03-27", result: "success")
    invoice_item = InvoiceItem.create!(item_id: 1, invoice_id: 1, quantity: 2, unit_price: 200)
    invoice_item_2 = InvoiceItem.create!(item_id: 2, invoice_id: 1, quantity: 1, unit_price: 100)
    invoice_item_3 = InvoiceItem.create!(item_id: 2, invoice_id: 2, quantity: 2, unit_price: 100)
    invoice_item_4 = InvoiceItem.create!(item_id: 3, invoice_id: 3, quantity: 1, unit_price: 300)


    get '/api/v1/merchants/1/revenue'

    expect(response).to be_success

    revenue = JSON.parse(response.body)
    expect(revenue).to eq(800)
  end
end
