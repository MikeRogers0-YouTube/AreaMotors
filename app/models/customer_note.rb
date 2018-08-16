class CustomerNote < ApplicationRecord
  belongs_to :customer

  validates :body, presence: true

  def to_s
    body
  end
end
