class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer

  belongs_to :user
end
