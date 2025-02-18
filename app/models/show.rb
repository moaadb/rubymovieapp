class Show < ApplicationRecord
  belongs_to :movie
  has_many :tickets, dependent: :destroy
  validates :date, :time, :seats_available, :ticket_price, presence: true
  validates :seats_available, numericality: { greater_than_or_equal_to: 0 }
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0 }
end
