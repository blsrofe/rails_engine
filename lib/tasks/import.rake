require 'csv'

desc "Import from csv file"
task :import => [:environment] do

  counter = 0

    file = "db/merchants.csv"

    puts 'Merchants'

    CSV.foreach(file, :headers => true) do |row|
      Merchant.create(row.to_hash)
      puts counter += 1
    end

    file = "db/customers.csv"

    puts 'Customers'

    CSV.foreach(file, :headers => true) do |row|
      Customer.create(row.to_hash)
      puts counter += 1
    end


    file = "db/invoices.csv"

    puts 'Invoices'

    CSV.foreach(file, :headers => true) do |row|
      Invoice.create(row.to_hash)
      puts counter += 1
    end

    file = "db/items.csv"

    puts 'Items'

    CSV.foreach(file, :headers => true) do |row|
      Item.create(row.to_hash)
      puts counter += 1
    end

    file = "db/transactions.csv"

    puts 'Transactions'

    CSV.foreach(file, :headers => true) do |row|
      Transaction.create(row.to_hash)
      puts counter += 1
    end

    file = "db/invoice_items.csv"

    puts 'Invoice Items'

    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create(row.to_hash)
      puts counter += 1
    end

  end
