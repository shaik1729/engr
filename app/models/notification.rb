class Notification < ApplicationRecord
    has_one_attached :file
    belongs_to :user
    belongs_to :college
    belongs_to :department, optional: true
    belongs_to :batch, optional: true
    belongs_to :regulation, optional: true

    validates :title, presence: true
    validates :file, presence: true

end
