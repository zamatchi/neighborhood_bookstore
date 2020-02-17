class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  include Hashid::Rails
  # has_many :cart_products, dependent: :destroy
end
