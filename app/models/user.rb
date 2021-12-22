# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
  validates :name, uniqueness: true

  belongs_to :role
  has_many :comments
  has_many :events
  has_many :has_items, through: :events, source: :items
  has_many :commented_events, through: :comments, source: :event
end
