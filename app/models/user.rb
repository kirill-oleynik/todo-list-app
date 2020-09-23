# frozen_string_literal: true

# todolists owner entity
class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true
end
