class Family < ApplicationRecord

  # Relationships
  has_many :users, foreign_key: :family_id

  # Validations
  validates_presence_of :family_name

  # Scopes
  scope :alphabetical, -> { order('family_name')}

  # Methods
  # look up all questions for family
  def look_up_questions
  end
end
