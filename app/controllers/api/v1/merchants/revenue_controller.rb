module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        def show
          binding.pry
          render json: Merchant.joins(:transactions).where(transactions: {result: "success"}).pluck(:invoice_id).joins(:invoice_items).distinct.sum("unit_price * quantity")
        end
      end
    end
  end
end
