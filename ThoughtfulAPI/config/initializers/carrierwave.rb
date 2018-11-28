CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET']
  }
  config.fog_directory  = ENV['S3_BUCKET']                                      # required
  config.fog_public     = false           # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}

  config.cache_dir = "#{Rails.root}/tmp/uploads"       # To let CarrierWave work on heroku
end
