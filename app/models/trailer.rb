# frozen_string_literal: true

class Trailer < ApplicationRecord
  belongs_to :user
  validates :make, :user, presence: true
end
