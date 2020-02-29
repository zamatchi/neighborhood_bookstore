class PurchaseHistoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :purchase_history
end