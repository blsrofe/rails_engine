module Api
  module V1
    module Merchants
      class MostItemsController < ApplicationController
        def index
          render json: Merchant.sold_most_items(params[:quantity])
        end
      end
    end
  end
end
