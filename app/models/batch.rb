class Batch < ApplicationRecord
    belongs_to :user
    has_many :results
    belongs_to :college
    has_many :notifications
end
