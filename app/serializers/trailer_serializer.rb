# frozen_string_literal: true

class TrailerSerializer < ActiveModel::Serializer
  attributes :id, :make, :model, :year, :trailer_type, :hitch_type, :length, :gvwr
<<<<<<< HEAD

=======
  def editable
    scope == object.user
  end
>>>>>>> dev
end
