module Api
  module V1
    class RevenueController < ApplicationController
      def show
        render json: Merchant.find(params[:merchant_id]).total_revenue
      end
    end
  end
end
