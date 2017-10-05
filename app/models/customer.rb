class Customer < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
      .select('merchants.*, count(transactions.id) as transaction_count')
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('transaction_count desc')
      .first
  end

  # select("merchants.*, sum(invoice_items.quantity) as quantity")
  #   .joins(:transactions, :invoice_items)
  #   .merge(Transaction.successful)
  #   .group(:id)
  #   .order('quantity desc')
  #   .limit(num_of_records)

#   School.all(:select => "schools.*, AVG(reviews.score) as avg_score",
# :joins => :reviews,
# :group => 'schools.id',
# :order => 'avg_score desc',
# :limit => 10)

  # invoices
  #   .joins(:transactions, :invoice_items)
  #   .merge(Transaction.successful)
  #   .sum("invoice_items.quantity*invoice_items.unit_price")
end
