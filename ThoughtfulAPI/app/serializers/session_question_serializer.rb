class SessionQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_details, :correct,

  def question_details
    result = {}
    result["question_id"] = object.question.id
    result["question"] = object.question.question
    result["answer"] = object.question.answer
    result["attachment"] = object.question.attachment
    return result
  end
end
