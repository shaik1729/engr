class Notification < ApplicationRecord
    has_one_attached :file
    belongs_to :user
    belongs_to :college
    belongs_to :department
    belongs_to :batch
    belongs_to :regulation

    validates :title, presence: true
    validates :file, presence: true

end
