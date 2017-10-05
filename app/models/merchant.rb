class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.sold_most_items(num_of_records)
    select("merchants.*, sum(invoice_items.quantity) as quantity")
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .group(:id)
      .order('quantity desc')
      .limit(num_of_records)
  end

  def self.total_revenue
    # joins(:transactions).where(transactions: {result: "success"}).joins(:invoice_items).first.invoice_items.sum("unit_price * quantity")
    joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum("invoice_items.quantity*invoice_items.unit_price")
  end
end
