# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 500, minimum: 2 }
#  validates :content, length: { maximum: 500, minimum: 2 }
#   validates :finished_at_is_valid_datetime
#   def finished_at_is_valid_datetime
#     if begin
#       DateTime.parse(finished_at)
#     rescue StandardError
#       ArgumentError
#     end == ArgumentError
#       errors.add(:finished_at,
#                  'must be a valid datetime')
#     end
#   end
  belongs_to :user
  has_many :items
  has_many :comments
  # has_many :users, through: :commnets
  has_many :comentators, through: :comments, source: :user
end
