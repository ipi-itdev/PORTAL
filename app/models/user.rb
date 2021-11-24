class User < ApplicationRecord
  self.table_name = 'PORTAL_Users_C'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable , :validatable
  devise :database_authenticatable, :registerable,:rememberable ,:recoverable,:timeoutable, :validatable
  validates :EmployeeNumber,  :presence => true

  #dragonfly_accessor :image
  mount_uploader :image, ImageUploader
end
