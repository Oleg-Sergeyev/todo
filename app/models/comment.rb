class Comment < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 1000, minimum: 2 }

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
