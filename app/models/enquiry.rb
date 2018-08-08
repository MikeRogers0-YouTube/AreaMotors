class Enquiry < ApplicationRecord
  enum source: { 
    a_m_direct: 10, 
    cars_for_sale: 10, 
  }


  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
  validates :source, presence: true
end
