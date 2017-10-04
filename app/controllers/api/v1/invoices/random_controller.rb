module Api
  module V1
    module Invoices
      class RandomController < ApplicationController
        
        def show
          render json: Invoice.find_by_sql('SELECT * FROM invoices ORDER BY RANDOM() LIMIT 1;').first
        end

      end
    end
  end
end
