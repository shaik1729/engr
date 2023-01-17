class Subject < ApplicationRecord
    belongs_to :semester
    belongs_to :regulation
    belongs_to :college

    before_save :upcase_fields

    validates :name, presence: true
    validates :code, presence: true
    validates :regulation_id, presence: true
    validates :semester_id, presence: true
    validates :college_id, presence: true

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end
end
