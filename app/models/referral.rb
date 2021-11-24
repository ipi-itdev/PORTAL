class Referral < ApplicationRecord
    validates :name,:contact,:skills,:presence => true
    validates :name, length: { minimum: 2 , maximum: 200}
    validates :address, length: { maximum: 500}
    validates :phone, length: { maximum: 12}
    validates :skills, length: { maximum: 500}
    validates :remarks,  length: {maximum: 1000}
    validates :email, 'valid_email_2/email': true
end
