class Result < ApplicationRecord
    belongs_to :user
    belongs_to :semester
    belongs_to :batch
    belongs_to :regulation
    belongs_to :subject
    belongs_to :college
    belongs_to :department

    validates :semester_id, presence: true
    validates :batch_id, presence: true
    validates :regulation_id, presence: true
    validates :subject_id, presence: true
    validates :college_id, presence: true
    validates :department_id, presence: true
    validates :user_id, presence: true
    validates :internal_marks, presence: true
    validates :external_marks, presence: true
    validates :total_marks, presence: true
    validates :result, presence: true
    validates :credits, presence: true
    validates :grade, presence: true

end
