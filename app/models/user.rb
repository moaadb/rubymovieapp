# frozen_string_literal: true

# User model represents a user in the system with authentication support.
#
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_many :tickets, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
end
