class Item < ApplicationRecord
  default_scope {order(:id)}
end
