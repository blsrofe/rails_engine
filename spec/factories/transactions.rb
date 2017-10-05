FactoryGirl.define do
  factory :transaction do
    invoice_id 1
    credit_card_number "1234567891123456"
    credit_card_expiration_date nil
    result "success"
  end
end
