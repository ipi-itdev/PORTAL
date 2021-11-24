json.extract! userhero, :id, :name, :email, :login, :created_at, :updated_at
json.url userhero_url(userhero, format: :json)
