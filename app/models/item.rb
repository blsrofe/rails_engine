class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  default_scope {order(:id)}

  def self.most_items(num_of_records)
    unscoped.select('items.*, sum(invoice_items.quantity) as number_sold')
    .joins(invoice_items: [invoice: [:transactions]])
    .merge(Transaction.successful)
    .group(:id)
    .order('number_sold desc')
    .limit(num_of_records)
  end

  def best_day
    invoices
      .select('invoices.*, sum(invoice_items.quantity) as sales')
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order('sales desc, invoices.created_at desc')
      .first
  end
end

# .joins(invoice_items: [invoice: [:transactions]])

# def self.sold_most_items(num_of_records)
#   select("merchants.*, sum(invoice_items.quantity) as quantity")
#     .joins(:transactions, :invoice_items)
#     .merge(Transaction.successful)
#     .group(:id)
#     .order('quantity desc')
#     .limit(num_of_records)
# end

# def favorite_merchant
#   merchants
#     .select('merchants.*, count(transactions.id) as transaction_count')
#     .joins(invoices: [:transactions])
#     .merge(Transaction.successful)
#     .group(:id)
#     .order('transaction_count desc')
#     .first
# end
