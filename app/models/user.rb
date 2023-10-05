class User < ApplicationRecord
    has_many :organizations, dependent: :destroy
end
