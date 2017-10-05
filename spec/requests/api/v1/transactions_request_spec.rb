require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    invoice = create(:invoice)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get '/api/v1/transactions.json'

    expect(response).to be_success
    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
    invoice = create(:invoice)
    trans = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{trans.id}.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(trans.id)
  end

  it "can find one transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans["result"]).to eq(transaction.result)
    expect(trans.class).to eq(Hash)
  end

  it "can find multiple transactions" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans.count).to eq(3)

    get "/api/v1/transactions/find_all?result=success"

    expect(trans.count).to eq(3)
  end

  it "can find a random transaction" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 5, invoice_id: invoice.id)

    get "/api/v1/transactions/random.json"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans.class).to be(Hash)
  end
end
