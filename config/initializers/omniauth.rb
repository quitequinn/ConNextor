OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV["TWITTER_APP_ID"], ENV["TWITTER_SECRET"]
  provider :linkedin, ENV["LINKEDIN_APP_ID"], ENV["LINKEDIN_SECRET"]
end

