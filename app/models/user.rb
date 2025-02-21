class User < ApplicationRecord
  has_many :clips, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validation pour l'email et le username
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
