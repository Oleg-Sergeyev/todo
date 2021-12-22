# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, presence: true

  belongs_to :event
  has_one :has_user, through: :event, source: :user
end
