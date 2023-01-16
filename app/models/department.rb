class Department < ApplicationRecord
    belongs_to :user
    before_save :upcase_fields

    private

    def upcase_fields
        self.name = self.name.upcase
        self.short_form = self.short_form.upcase
        self.code = self.code.upcase
    end

end
