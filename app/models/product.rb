class Product < ApplicationRecord
  include Hashid::Rails
  mount_uploader :img, ImgUploader
  has_many :cart_products, dependent: :destroy
  has_many :purchase_history_products, dependent: :destroy
  validates :name, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :num, presence: true
end