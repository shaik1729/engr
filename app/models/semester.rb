class Semester < ApplicationRecord
    validates :sem, presence: true, uniqueness: true
    has_many :subjects
    has_many :results
end
