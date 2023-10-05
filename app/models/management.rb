class Management < ApplicationRecord
  belongs_to :organization

  has_many :activities, dependent: :destroy
end
