class Product < ApplicationRecord
  include Hashid::Rails
  mount_uploader :img, ImgUploader
  has_many :cart_products, dependent: :destroy
end
