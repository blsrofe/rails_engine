FactoryGirl.define do
  trait :with_items do
    transient do
      item_count 3
    end

    after(:create) do |object, evaluator|
      object.items << create_list(:item, evaluator.item_count)
    end
  end
end
