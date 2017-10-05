require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "finds a random merchant" do
    merchants = create_list(:merchant, 3)

    get '/api/v1/merchants/random.json'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant.class).to eq(Hash)
  end

  it "can find one item by its parameters" do
    merchant_1 = Merchant.create!(id: 1, name: "Larry")
    merchant_2 = Merchant.create!(id: 2, name: "Moe")
    merchant_3 = Merchant.create!(id: 3, name: "Curly")

    get "/api/v1/merchants/find?id=3"

    merchant = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchant["id"]).to eq(3)

    get "/api/v1/merchants/find?name=Moe"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq("Moe")
  end

  it "can find all items by its parameters" do
    merchant_1 = Merchant.create!(name: "Larry")
    merchant_2 = Merchant.create!(name: "Curly")
    merchant_3 = Merchant.create!(name: "Curly")


    get "/api/v1/merchants/find_all?name=Curly"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(2)
  end

  it "finds total revenue for merchant" do
    customer = Customer.create!(first_name: "Bob", last_name: "Smith")
    merchant = Merchant.create!(id: 1, name: "Larry")
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


    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    revenue = JSON.parse(response.body)
    expect(revenue).to eq(800)
  end

  it "returns top merchants ranked by total number of items sold" do
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
    invoice_item = InvoiceItem.create!(id: 1, item_id: 4, invoice_id: 4, quantity: 2, unit_price: 200)
    invoice_item_2 = InvoiceItem.create!(id: 2, item_id: 2, invoice_id: 1, quantity: 1, unit_price: 100)
    invoice_item_3 = InvoiceItem.create!(id: 3, item_id: 2, invoice_id: 2, quantity: 2, unit_price: 100)
    invoice_item_4 = InvoiceItem.create!(id: 4, item_id: 3, invoice_id: 2, quantity: 1, unit_price: 300)
    invoice_item_5 = InvoiceItem.create!(id: 5, item_id: 1, invoice_id: 3, quantity: 1, unit_price: 300)

    get "/api/v1/merchants/most_items?quantity=3"
    merchants = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchants.count).to eq(3)
    expect(merchants.first["name"]).to eq("Bob")
  end
end
