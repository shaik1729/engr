class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :college
  belongs_to :role
  has_many :batches
  has_many :regulations
  has_many :departments
  has_many :results
  has_many :documents
  has_many :notifications
  
  before_save :upcase_fields

  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :role_id, presence: true
  validates :college_id, presence: true
  
  def is_admin?
    self.role.code == "ADMIN"
  end

  def is_faculty?
    self.role.code == "FAC"
  end

  def is_student?
    self.role.code == "STU"
  end

  private

  def upcase_fields
    self.email.downcase!
    self.name&.upcase!
    self.reg_no&.upcase!
  end
end
