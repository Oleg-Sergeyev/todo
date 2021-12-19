# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 300, minimum: 2 }
  validates :code, length: { maximum: 300, minimum: 2 }
end
