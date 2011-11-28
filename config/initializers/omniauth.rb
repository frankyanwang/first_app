Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '262076010510712', '39ffff2f77ad2d8594618f61e9bd97b7'
  provider :twitter, '5BNz6viPcFxtdRKPTmVA', 'FWBdNHDOY55lCAQQdU9YCfW0vi0fJbNMVKgYffLTPo'
end

