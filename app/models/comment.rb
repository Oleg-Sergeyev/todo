class Comment < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 1000, minimum: 2 }

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :seos
  has_many :seos, as: :promoted
  has_many :promotions, through: :seos, source: :user
end
