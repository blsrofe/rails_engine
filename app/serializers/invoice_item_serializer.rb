class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    object.unit_price.to_s.insert(-3, '.')
  end
end
