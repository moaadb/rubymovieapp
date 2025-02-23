# frozen_string_literal: true

# User model represents a user in the system with authentication support.
#
class User < ApplicationRecord
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true,
    format:
    {
      with: /\A[A-Za-z0-9\-\_\.]*@[A-Za-z0-9\-\_\.]*\.[A-Za-z0-9\-\_\.]*\z/,
      message: "The email must contain an @ sign and a domain (e.g. name@domain.com)."
    }

  validates :username,
    presence: true,
    uniqueness: true
  
  has_many :tickets, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
end
