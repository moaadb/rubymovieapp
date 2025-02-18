class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :credit_card, optional: true

  validates :confirmation_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[Booked Cancelled] }
  validates :credit_card_id, presence: true, unless: -> { user&.admin? }

  before_validation :generate_confirmation_number, on: :create

  private

  def generate_confirmation_number
    self.confirmation_number ||= SecureRandom.hex(8).upcase
  end
end
