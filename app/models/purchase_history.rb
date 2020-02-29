class PurchaseHistory < ApplicationRecord
  belongs_to :user
  has_many :purchase_history_products, dependent: :destroy
  has_many :products, through: :purchase_history_products
end
