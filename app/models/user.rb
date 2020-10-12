# frozen_string_literal: true

# todolists owner entity
class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true
end