json.extract! referral, :id, :name, :address, :email, :phone, :position, :note, :employeerefno, :created_at, :updated_at
json.url referral_url(referral, format: :json)
