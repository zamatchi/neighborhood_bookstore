class PurchaseHistoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :purchase_history
  validates :delivery_user, presence: true
end