class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :college
  belongs_to :role
  has_many :batches
  has_many :regulations
  has_many :departments

  
  def is_admin?
    self.role.code == "ADMIN"
  end

end
