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
  end
end
