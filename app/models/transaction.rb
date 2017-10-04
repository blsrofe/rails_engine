class Transaction < ApplicationRecord
  scope :successful, -> {where(result: 'success')}
end
