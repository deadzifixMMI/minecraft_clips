class Clip < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :video, presence: true
end
