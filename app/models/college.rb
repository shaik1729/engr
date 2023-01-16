class College < ApplicationRecord
    has_many :users

    before_save :upcase_fields

    validates :name, presence: true, uniqueness: true
    validates :short_form, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true

    private

    def upcase_fields
        self.name = self.name.upcase
        self.short_form = self.short_form.upcase
        self.code = self.code.upcase
    end

end
