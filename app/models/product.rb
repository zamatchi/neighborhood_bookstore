class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  include Hashid::Rails
end
