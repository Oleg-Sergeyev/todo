# frozen_string_literal: true

# class Seo < ApplicationRecord
class Seo < ApplicationRecord
  validates :title, length: { maximum: 70, minimum: 0 }
  validates :description, length: { maximum: 155 }
  validates :keywords, length: { maximum: 600, minimum: 0 }

  # belongs_to :comment
  # belongs_to :promoted, polymorphic: true
  belongs_to :promoted, polymorphic: true
end
