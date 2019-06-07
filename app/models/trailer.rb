# frozen_string_literal: true

class Trailer < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
=======
  validates :make, :user, presence: true
>>>>>>> dev
end
