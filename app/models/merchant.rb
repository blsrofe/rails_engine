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

  def self.most_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .joins(invoices: [:transactions, :invoice_items])
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.revenue_by_date(date = nil)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where('invoices.created_at = ?', date)
      .sum('quantity * unit_price')
  end

  def total_revenue
    invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum("invoice_items.quantity*invoice_items.unit_price")
  end

  def favorite_customer
    Customer.select("customers.*, count(invoices.id)")
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .where('invoices.merchant_id = ?', self.id)
      .group(:id)
      .order("count DESC")
      .first
  end
end
