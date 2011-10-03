CarrierWave.configure do |config|

  # used for store images in Rails root folder tmp directories where Heroku is allowed to write file
  if ENV["RAILS_ENV"] == "production"
    config.root = Rails.root.join('tmp')      
  end
  
  config.cache_dir = 'carrierwave_cache'
  
  config.s3_access_key_id = ENV['s3_access_key_id']
  config.s3_secret_access_key = ENV['s3_secret_access_key']
  config.s3_bucket = ENV['s3_bucket']
end