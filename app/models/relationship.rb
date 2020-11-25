class Relationship < ApplicationRecord
  belongs_to :user
  has many :katchups
  has_many :restaurants, theough: :katchups
end
