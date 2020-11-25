class Restaurant < ApplicationRecord
    has_many :katchups
    has_many :relationship, through: :katchups 
end
