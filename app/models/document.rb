class Document < ApplicationRecord
    has_one_attached :file

    belongs_to :user
    belongs_to :department
    belongs_to :regulation
    belongs_to :subject
    belongs_to :college
    belongs_to :semester

    before_save :upcase_fields


    validates :title, presence: true
    validates :content, presence: true
    validates :department_id, presence: true
    validates :regulation_id, presence: true
    validates :subject_id, presence: true
    validates :college_id, presence: true
    validates :user_id, presence: true
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

    def upcase_fields
        self.title = self.title.upcase
    end
end
