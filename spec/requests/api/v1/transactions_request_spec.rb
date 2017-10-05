require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions.json'

    expect(response).to be_success
    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
    trans = create(:transaction)

    get "/api/v1/transactions/#{trans.id}.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(trans.id)
  end

  it "can find one transaction" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans["result"]).to eq(transaction.result)
    expect(trans.class).to eq(Hash)
  end

  it "can find multiple transactions" do
    transactions = create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?invoice_id=1"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans.count).to eq(3)

    get "/api/v1/transactions/find_all?result=success"

    expect(trans.count).to eq(3)
  end

  it "can find a random transaction" do
    transactions = create_list(:transaction, 5)

    get "/api/v1/transactions/random.json"

    trans = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans.class).to be(Hash)
  end
end
