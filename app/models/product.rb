class Product < ApplicationRecord
  belongs_to :restaurant
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where(available: true) }
  scope :veg, -> { where(is_veg: true) }
  scope :non_veg, -> { where(is_veg: false) }
  scope :search_by_keyword, ->(q) {
    where("LOWER(name) LIKE :q OR LOWER(description) LIKE :q", q: "%#{q.downcase}%")
  }

  def display_image
    image_url.presence || "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80"
  end
end
