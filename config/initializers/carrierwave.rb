CarrierWave.configure do |config|
  # used for store images in Rails root folder tmp directories where Heroku is allowed to write files to.
  # config.root = Rails.root.join('tmp')
  # config.cache_dir = 'carrierwave'    

  config.s3_access_key_id = ENV['s3_access_key_id']
  config.s3_secret_access_key = ENV['s3_secret_access_key']
  config.s3_bucket = ENV['s3_bucket']
end