class Semester < ApplicationRecord
    validates :sem, presence: true, uniqueness: true
    has_many :results
    has_many :documents
end
