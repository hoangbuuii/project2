class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
  validates :name, presence: true, length: {maximum:Settings.tag_max_length_name}
end
