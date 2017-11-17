class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum:Settings.post_max_length_title}
  validates :content, presence: true, length: {maximum:Settings.post_max_length_content}
end
