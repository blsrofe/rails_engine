module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController

        def index
          render json: Merchant.revenue(params[:date]), each_serializer: MerchantsRevenueSerializer
        end

      end
    end
  end
end
