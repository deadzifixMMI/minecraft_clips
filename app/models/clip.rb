class Clip < ApplicationRecord
  belongs_to :user
  has_one_attached :video
end
