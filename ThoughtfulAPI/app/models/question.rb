class Question < ApplicationRecord
  # https://github.com/carrierwaveuploader/carrierwave
  mount_uploader :attachment, AttachmentUploader

  # Relationships
  belongs_to :user, foreign_key: :created_by

  # Validations
  validates_presence_of :question, :answer, :created_by
  # attachment is optional bc not all questions may have an image that goes with it

  # Scopes
  scope :for_user, ->(user_id){ where('user_id = ?', user_id)}

  # Methods
  def has_attachment
    !attachment.nil? && attachment != "" && !attachment.file.nil?
  end
end
