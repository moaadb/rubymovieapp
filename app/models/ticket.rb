class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :credit_card, optional: true

  validates :confirmation_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[Booked Cancelled] }
  validates :credit_card_id, presence: true, unless: -> { user&.admin? }

  before_validation :generate_confirmation_number, on: :create
  after_destroy :increment_seats_available

  private

  def generate_confirmation_number
    self.confirmation_number ||= SecureRandom.hex(8).upcase
  end

  def increment_seats_available
    show.update(seats_available: show.seats_available + 1) if show.present?
  end
end
