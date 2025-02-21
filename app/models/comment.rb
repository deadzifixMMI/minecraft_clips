class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :clip
  validates :content, presence: true
end
