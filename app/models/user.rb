class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :college
  belongs_to :role
  belongs_to :batch, optional: true
  belongs_to :department, optional: true
  belongs_to :regulation, optional: true
  
  has_many :results
  has_many :documents
  has_many :notifications
  
  before_save :upcase_fields

  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :role_id, presence: true
  validates :college_id, presence: true
  validates :mobile_number, presence: true, length: { is: 10 }, numericality: { only_integer: true }
  
  def is_admin?
    self.role.code == "ADMIN"
  end

  def is_staff?
    self.role.code == "STAFF"
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
