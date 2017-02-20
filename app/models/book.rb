class Book < ApplicationRecord
	has_and_belongs_to_many :categories
	mount_uploader :image, ImageUploader
	has_many :orders, dependent: :destroy
  	has_many :users, through: :orders
end
