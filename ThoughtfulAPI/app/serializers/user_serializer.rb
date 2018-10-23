class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :proper_name, :role, :family_name
  def user_id
    object.id
  end

  def proper_name
    object.proper_name
  end

  def family_name
    object.family.family_name
  end


end
