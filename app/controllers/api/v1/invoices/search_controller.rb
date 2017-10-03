module Api
  module V1
    module Invoices
      class SearchController < ApplicationController

        def show
          render json: Invoice.find_by(search_params)
        end

        private

        def search_params
          params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
        end
      end
    end
  end
end
