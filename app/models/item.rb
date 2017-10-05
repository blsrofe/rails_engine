class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  default_scope {order(:id)}
end
