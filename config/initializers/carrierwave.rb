CarrierWave.configure do |config|
  config.cache_storage = :file
  config.storage_engines[:ftp] = 'CarrierWave::Storage::FTP'
  config.ftp_host = Rails.application.credentials.ftp_host
  #config.ftp_port = 21
  config.ftp_user = Rails.application.credentials.ftp_user
  config.ftp_passwd = Rails.application.credentials.ftp_password
  config.ftp_folder = "/tmspits"
  config.ftp_url = 'https://tms.pitsph.com'
  config.ftp_passive = false # false by default
  config.ftp_tls = false # false by default
  config.ftp_chmod = false
end

