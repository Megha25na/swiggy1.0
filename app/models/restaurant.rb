class Restaurant < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :nullify

  validates :name, presence: true

  scope :featured, -> { where(featured: true) }
  scope :pure_veg, -> { where(pure_veg: true) }
  scope :search_by_keyword, ->(q) {
    where("LOWER(name) LIKE :q OR LOWER(cuisine) LIKE :q OR LOWER(description) LIKE :q", q: "%#{q.downcase}%")
  }

  def display_image
    image_url.presence || "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80"
  end

  def available_categories
    products.where(available: true).pluck(:category).compact.uniq
  end
end
