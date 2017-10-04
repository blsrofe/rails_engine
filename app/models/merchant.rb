class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices

  has_many :items

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
