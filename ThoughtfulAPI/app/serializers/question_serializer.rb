class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :attachment

  belongs_to :user
end
