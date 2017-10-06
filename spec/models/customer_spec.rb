require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'associations' do
    it {is_expected.to have_many(:invoices)}
    it {is_expected.to have_many(:customers).through(:invoices)}
    it {is_expected.to have_many(:merchants).through(:invoices)}
    it {is_expected.to have_many(:transactions).through(:invoices)}
    it {is_expected.to have_many(:invoice_items).through(:invoices)}
  end
end
