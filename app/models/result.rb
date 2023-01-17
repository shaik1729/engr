class Result < ApplicationRecord
    belongs_to :user
    belongs_to :semester
    belongs_to :batch
    belongs_to :regulation
    belongs_to :subject
    belongs_to :college
end
