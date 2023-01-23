class Regulation < ApplicationRecord
    has_many :subjects
    has_many :results
    has_many :documents
    has_many :notifications
    has_many :users
    
    belongs_to :college

    before_save :upcase_fields

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end
end
