class User < ApplicationRecord

  # Relationships
  has_one :family, foreign_key: :patient_id
  belongs_to :family, foreign_key: :family_id

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
