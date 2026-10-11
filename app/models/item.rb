class Item < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  def unit_price
    price.presence || product&.price || 0
  end

  def line_total
    unit_price * (quantity || 1)
  end
end
