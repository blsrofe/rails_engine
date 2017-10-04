require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_success
    customers = JSON.parse(response.body)
    expect(customers.count).to eq(3)
  end

  it "can get one customer by its id" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}.json"

    cust = JSON.parse(response.body)

    expect(response).to be_success
    expect(cust["id"]).to eq(customer.id)
  end

  it "can find one customer" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    cust = JSON.parse(response.body)

    expect(response).to be_success
    expect(cust["last_name"]).to eq(customer.last_name)
    expect(cust.class).to eq(Hash)
  end

  it "can find multiple customers" do
    customers = create_list(:customer, 3)

    get "/api/v1/customers/find_all?last_name=Smith"

    cust = JSON.parse(response.body)

    expect(response).to be_success
    expect(cust.count).to eq(3)

    get "/api/v1/customers/find_all?first_name=Bob"

    expect(cust.count).to eq(3)
  end

  it "can find a random customer" do
    customers = create_list(:customer, 5)

    get "/api/v1/customers/random.json"

    cust = JSON.parse(response.body)

    expect(response).to be_success
    expect(cust.class).to be(Hash)
  end
end
