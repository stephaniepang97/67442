class PatientSessionSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :total_correct, :total_answered

  belongs_to :user
  has_many :session_questions

  def total_correct
    object.session_questions.correctly_answered.count
  end

  def total_answered
    object.session_questions.count
  end

end
