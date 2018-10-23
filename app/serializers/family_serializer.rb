class FamilySerializer < ActiveModel::Serializer
  attributes :family_id, :family_name
  has_many :users


  def family_id
    object.id
  end

end
