class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :clips, dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, authentication_keys: [ :username ]

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true # Garde l'email obligatoire
  # Devise : permet la connexion avec username au lieu de l'email
  def self.find_for_database_authentication(warden_conditions)
    where(username: warden_conditions[:username]).first
  end
end
