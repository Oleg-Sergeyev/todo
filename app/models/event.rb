# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 500, minimum: 2 }

  belongs_to :user
  has_many :items
  has_many :comments, as: :commentable
  # has_many :users, through: :commnets
  has_many :comentators, through: :comments, source: :user
end
