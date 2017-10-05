class Customer < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants
      .select('merchants.*, count(transactions.id) as transaction_count')
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('transaction_count desc')
      .first
  end  
end
