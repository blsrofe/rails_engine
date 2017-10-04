module Api
  module V1
    class RevenueController < ApplicationController
      def show
        render json: Merchant.total_revenue
      end
    end
  end
end
