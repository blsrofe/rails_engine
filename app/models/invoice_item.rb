class InvoiceItem < ApplicationRecord
  belongs_to :item
  belgons_to :invoices
end
