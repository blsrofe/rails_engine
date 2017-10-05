module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        def show
          render json: Merchant.find(params[:id]).total_revenue
        end
      end
    end
  end
end
