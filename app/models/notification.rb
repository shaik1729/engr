class Notification < ApplicationRecord
    has_one_attached :file
    belongs_to :user
    belongs_to :college
    belongs_to :department, optional: true
    belongs_to :batch, optional: true
    belongs_to :regulation, optional: true

    validates :title, presence: true
    validates :file, presence: true

    validate :validate_document

    private

    def validate_document
        if file.attached? && !file.content_type.in?(%w(application/zip application/pdf))
          errors.add(:file, 'Must be a PDF or a ZIP file')
        end
        if file.attached? && file.blob.byte_size > 5.megabytes
          errors.add(:file, 'Must be less than 5MB in size')
        end
    end
end
