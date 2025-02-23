class CreditCard < ApplicationRecord
  belongs_to :user

  validates :card_number,
    presence: true,
    format:
    {
      with: /\A\d{16}\z/,
      message: "Credit Card must contain 16 digits"
    }
    
  validates :expiration_date, presence: true
end
