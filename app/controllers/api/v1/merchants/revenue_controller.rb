module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController

        def index
          render json: Merchant.revenue_by_date(params[:date]), serializer: MerchantRevenueSerializer
        end

      end
    end
  end
end
