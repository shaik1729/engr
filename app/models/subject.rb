class Subject < ApplicationRecord
    belongs_to :semester
    belongs_to :regulation
    belongs_to :college


    has_many :results
    has_many :documents
    
    before_save :upcase_fields

    validates :name, presence: true
    validates :code, presence: true
    validates :regulation_id, presence: true
    validates :semester_id, presence: true
    validates :college_id, presence: true

    def subject_name
        "#{self.code} (#{self.name})"
    end

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end
end
