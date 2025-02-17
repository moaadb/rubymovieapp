# frozen_string_literal: true

# User model represents a user in the system with authentication support.
#
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
