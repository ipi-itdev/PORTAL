json.extract! contactpage, :id, :name, :email, :subject, :message, :created_at, :updated_at
json.url contactpage_url(contactpage, format: :json)
