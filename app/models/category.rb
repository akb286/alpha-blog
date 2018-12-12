class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximim: 25 }
  validates_uniqueness_of :name
end
