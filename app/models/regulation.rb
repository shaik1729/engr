class Regulation < ApplicationRecord
    belongs_to :user

    has_many :subjects

    before_save :upcase_fields

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end
end
