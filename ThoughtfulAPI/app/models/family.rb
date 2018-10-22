class Family < ApplicationRecord

  # Relationships
  belongs_to :user, foreign_key: :patient_id
  has_many :users, foreign_key: :family_id

  # Validations
  validates_presence_of :family_name

  # Scopes
  scope :alphabetical, -> { order('family_name')}
end
