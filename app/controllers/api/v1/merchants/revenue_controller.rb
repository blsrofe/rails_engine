module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        
        def index
          render json: Merchant.revenue_by_date(params[:date]), serializer: MerchantRevenueSerializer
        end
        
        def show
          if params[:date]
            revenue = Merchant.find(params[:id]).total_revenue_by_date(params[:date])
            render json: revenue, :serializer => RevenueSerializer
          else
            revenue = Merchant.find(params[:id]).total_revenue
            render json: revenue, :serializer => RevenueSerializer
          end
        end

      end
    end
  end
end
