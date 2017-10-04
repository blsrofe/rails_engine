FactoryGirl.define do
  factory :item do
    sequence :name do |x|
      "Unicycle #{x}"
    end
    sequence :description do |x|
      "One Wheeled Madness #{x}"
    end
    unit_price 1
    merchant_id 1
  end
end
