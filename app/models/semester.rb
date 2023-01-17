class Semester < ApplicationRecord
    validates :sem, presence: true, uniqueness: true
end
