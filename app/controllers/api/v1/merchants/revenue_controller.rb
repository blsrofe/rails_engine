module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        def show
          revenue = Merchant.find(params[:id]).total_revenue
          render json: revenue -> RevenueSerializer
        end
      end
    end
  end
end
