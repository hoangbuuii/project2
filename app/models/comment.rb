class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user, presence: true
  validates :micropost, presence: true
  validates :content, presence: true, length: {maximum: Settings.comment_max_length_content}
end
