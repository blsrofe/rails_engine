module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          # render json: Merchant.find_all(params[:id])
        end

        def show
          render json: Merchant.where(name: params[:name])
        end
      end
    end
  end
end
