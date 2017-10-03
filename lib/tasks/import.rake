require 'csv'

desc "Import from csv file"
task :import => [:environment] do

    file = "db/merchants.csv"

    CSV.foreach(file, :headers => true) do |row|
      Merchant.create {
        :id => row[1],
        :name => row[2],
        :created_at => row[3],
        :updated_at => row[4]
      }
    end

    file = "db/customers.csv"

    CSV.foreach(file, :headers => true) do |row|
      Customer.create {
        :id => row[1],
        :first_name => row[2],
        :last_name => row[3],
        :created_at => row[4],
        :updated_at => row[5]
      }
    end

    file = "db/transactions.csv"

    CSV.foreach(file, :headers => true) do |row|
      Transaction.create {
        :id => row[1]
        :invoice_id => row[2],
        :credit_card_number => row[3],
        :credit_card_expiration_date => row[4],
        :result => row[5],
        :created_at => row[6],
        :updated_at => row[7]
      }
    end

    file = "db/invoice_items.csv"

    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create {
        :id => row[1]
        :item_id => row[2],
        :invoice_id => row[3],
        :quantity => row[4],
        :unit_price => row[5],
        :created_at => row[6],
        :updated_at => row[7]
      }
    end

    file = "db/invoices.csv"

    CSV.foreach(file, :headers => true) do |row|
      Invoice.create {
        :id => row[1]
        :customer_id => row[2],
        :merchant_id => row[3],
        :status => row[4],
        :created_at => row[5],
        :updated_at => row[6]
      }
    end

    file = "db/items.csv"

    CSV.foreach(file, :headers => true) do |row|
      Item.create {
        :id => row[1],
        :name => row[2],
        :description => row[3],
        :unit_price => row[4],
        :merchant_id => row[5],
        :created_at => row[6],
        :updated_at => row[7]
      }
    end
  end
