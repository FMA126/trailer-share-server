# frozen_string_literal: true

class ExampleSerializer < ActiveModel::Serializer
  attributes :id, :text, :editable
  belongs_to :user
  def editable
    scope == object.user
  end
end
