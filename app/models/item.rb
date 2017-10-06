class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  default_scope {order(:id)}


  def self.most_revenue(quantity)
    unscoped.select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items)
      .group("items.id")
      .order("revenue DESC")
      .limit(quantity)
  end
  
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

