class User < ApplicationRecord

  # Relationships
  belongs_to :family, foreign_key: :family_id
  has_many :patient_sessions, foreign_key: :patient_id
  has_many :questions, foreign_key: :created_by

  # Validations
  validates_presence_of :first_name, :last_name, :role, :family_id

  # Scopes
  scope :alphabetical, -> { order('last_name, first_name')}

  # Other methods
  def name
    last_name + ", " + first_name
  end

  def proper_name
    first_name + " " + last_name
  end

end
