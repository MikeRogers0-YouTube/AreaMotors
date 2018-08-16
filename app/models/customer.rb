class Customer < ApplicationRecord
  has_many :enquiries
  has_many :customer_notes
end
