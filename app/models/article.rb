class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true

  def self.search(search)
    if search
      losearch = search.downcase
      # The LIKE syntax is used for MySQL, but if you are deploying to Heroku or another platform that uses PostgreSQL use the like syntax instead.
      where("lower(title) like ? OR lower(description) like ?", "%#{search.downcase}%", "%#{search.downcase}%")
    end
  end
end
