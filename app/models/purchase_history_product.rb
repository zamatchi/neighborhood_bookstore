class PurchaseHistoryProduct < ApplicationRecord
  require 'csv'
  belongs_to :product
  belongs_to :purchase_history
  validates :delivery_user, presence: true
end