require 'rails_helper'

RSpec.describe "Items API" do
  context "GET /items" do
    it "sends a list of items" do
      create_list(:item, 3)

      get "/api/v1/items.json"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end

    it "sends one item" do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(item.name)
      expect(json["description"]).to eq(item.description)
    end

    it "can find one item" do
      item = create_list(:item, 3, unit_price: 1006)

      get "/api/v1/items/find?name=#{item[1].name}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(item[1].name)
      expect(json["unit_price"]).to eq("10.06")

      get "/api/v1/items/find?description=#{item[0].description}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq(item[0].description)
      expect(json["unit_price"]).to eq("10.06")

      get "/api/v1/items/find?unit_price=#{item[2].unit_price}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq(item[0].description)
      expect(json["name"]).to eq(item[0].name)
    end

    it "can find multiple items" do
      items = create_list(:item, 5)

      get "/api/v1/items/find_all?merchant_id=#{items[1].merchant_id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq(5)
      expect(json.class).to be(Array)
    end

    it "can find a random item" do
      items = create_list(:item, 5)

      get "/api/v1/items/random.json"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.class).to be(Hash)
    end
  end
end
