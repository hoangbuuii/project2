class Tagging < ApplicationRecord
  belongs_to :micropost
  belongs_to :tag
end
