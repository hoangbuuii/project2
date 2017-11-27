class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
  validates :name, presence: true, length: {maximum:Settings.tag_max_length_name}

  def self.counts
    self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end
end
