class Api::V1::Merchants::RevenueController::MerchantsRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    object.total_revenue.to_s.insert(-3, '.')
  end
end
