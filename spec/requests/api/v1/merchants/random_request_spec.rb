require 'rails_helper'

describe "Merchants API" do
  it "finds a random merchant" do
    merchants = create_list(:merchant, 3)

    get '/api/v1/merchants/random.json'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant.class).to eq(Hash)
  end
end
