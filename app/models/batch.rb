class Batch < ApplicationRecord
    has_many :results
    belongs_to :college
    has_many :notifications
    has_many :users

    validates :year, presence: true
end
