FactoryGirl.define do
  factory :transaction do
    invoice_id 1
    credit_card_number "1234123412341234"
    credit_card_expiration_date "2014-12-03"
    result "Success"
  end
end
