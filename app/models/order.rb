class Order < ApplicationRecord
  STATUSES = %w[placed confirmed preparing out_for_delivery delivered cancelled].freeze

  belongs_to :user, optional: true
  belongs_to :restaurant, optional: true
  has_many :items, dependent: :destroy
  has_many :products, through: :items

  before_validation :sync_restaurant_foreign_keys
  before_create :set_default_status

  validates :total, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  def sync_restaurant_foreign_keys
    if restaurant_id.present? && restru_id.blank?
      self.restru_id = restaurant_id
    elsif restru_id.present? && restaurant_id.blank?
      self.restaurant_id = restru_id
    end
  end

  def set_default_status
    self.order_status ||= "placed"
    self.payment_status ||= "paid"
  end

  def status_badge_class
    case order_status
    when "placed" then "badge-status-placed"
    when "confirmed" then "badge-status-confirmed"
    when "preparing" then "badge-status-preparing"
    when "out_for_delivery" then "badge-status-delivering"
    when "delivered" then "badge-status-delivered"
    when "cancelled" then "badge-status-cancelled"
    else "badge-status-default"
    end
  end

  def tracking_step_number
    case order_status
    when "placed" then 1
    when "confirmed" then 2
    when "preparing" then 3
    when "out_for_delivery" then 4
    when "delivered" then 5
    else 1
    end
  end

  def active?
    !%w[delivered cancelled].include?(order_status)
  end
end
