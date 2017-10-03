require 'rails_helper'

describe "Merchants search API" do
  it "can find one item by its parameters" do
    merchant_1 = Merchant.create!(name: "Larry")
    merchant_2 = Merchant.create!(name: "Moe")
    merchant_3 = Merchant.create!(name: "Curly")

    get "/api/v1/merchants/find?id=3"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(3)

    get "/api/v1/merchants/find?name=Moe"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq("Moe")    
  end
end
