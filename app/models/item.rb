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
end
