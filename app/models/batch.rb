class Batch < ApplicationRecord
    has_many :results
    belongs_to :college
    has_many :notifications

    validates :year, presence: true
end
