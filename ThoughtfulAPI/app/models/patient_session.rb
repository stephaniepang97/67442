class PatientSession < ApplicationRecord

  # Relationships
  belongs_to :user, foreign_key: :patient_id
  has_many :session_questions

  # Validations
  validates_presence_of :patient_id, :start_time
  validates_datetime :start_time, on_or_before: -> { DateTime.now }
  validates_datetime :end_time, allow_blank: true, on_or_after: :start_time

end
