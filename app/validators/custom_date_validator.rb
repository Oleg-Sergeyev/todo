# frozen_string_literal: true
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
