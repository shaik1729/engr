class Department < ApplicationRecord
    belongs_to :user
    before_save :upcase_fields
    
    has_many :documents
    belongs_to :college

    private

    def upcase_fields
        self.name = self.name.upcase
        self.short_form = self.short_form.upcase
        self.code = self.code.upcase
    end

end
