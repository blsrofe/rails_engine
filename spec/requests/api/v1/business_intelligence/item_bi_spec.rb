require 'rails_helper'

RSpec.describe "Item BI Endpoints" do
  it "sends the top X items ranked by revenue" do

    get "/api/v1/items/most_revenue"

    expect(response).to be_success
  end
end

