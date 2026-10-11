class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  validates :name, presence: true, on: :update

  def admin?
    role == "admin"
  end

  def customer?
    role.blank? || role == "customer"
  end

end
