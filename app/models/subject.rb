class Subject < ApplicationRecord
    belongs_to :regulation
    belongs_to :college


    has_many :results
    has_many :documents
    
    before_save :upcase_fields

    before_create :verify_subject_existence

    validates :name, presence: true
    validates :code, presence: true
    validates :regulation_id, presence: true
    validates :college_id, presence: true

    def subject_name
        "#{self.code} (#{self.name})"
    end

    def verify_subject_existence
        if Subject.where(code: self.code, regulation_id: self.regulation_id, college_id: self.college_id).exists?
            errors.add(:code, "Subject already exists")
            throw(:abort)
        end
    end

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end
end
