class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :college
  belongs_to :role
  has_many :batches
  has_many :regulations
  has_many :departments

  
  def is_admin?
    self.role.code == "ADMIN"
  end

  def is_faculty?
    self.role.code == "FAC"
  end

  def is_student?
    self.role.code == "STU"
  end

end
