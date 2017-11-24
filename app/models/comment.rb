class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user, presence: true
  validates :post, presence: true
  validates :content, presence: true, length: {maximum: Settings.comment_max_length_content}
  scope :order_by_created_at_desc, ->{order created_at: :desc}
end
