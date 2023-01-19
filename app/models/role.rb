class Role < ApplicationRecord
    has_many :users
    
    before_save :upcase_fields

    validates :name, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true

    def is_admin?
        self.code == "ADMIN"
    end

    def is_faculty?
        self.code == "FAC"
    end

    def is_student?
        self.code == "STU"
    end

    private

    def upcase_fields
        self.name = self.name.upcase
        self.code = self.code.upcase
    end

end
