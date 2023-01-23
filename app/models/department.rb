class Department < ApplicationRecord
    before_save :upcase_fields
    
    has_many :documents
    has_many :notifications
    has_many :results
    has_many :users
    
    belongs_to :college

    validates :name, presence: true
    validates :short_form, presence: true
    validates :code, presence: true
    validates :college_id, presence: true

    private

    def upcase_fields
        self.name = self.name.upcase
        self.short_form = self.short_form.upcase
        self.code = self.code.upcase
    end

end
