class SessionQuestion < ApplicationRecord
  belongs_to :patient_session_id
  belongs_to :question_id
end
