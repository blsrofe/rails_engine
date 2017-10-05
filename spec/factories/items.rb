FactoryGirl.define do
  factory :item do
    sequence :name do |x|
      "Unicycle #{x}"
    end
    sequence :description do |x|
      "One Wheeled Madness #{x}"
    end
    sequence :unit_price do |x|
      x
    end
    merchant_id 1
  end
end
