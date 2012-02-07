Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mailchimp, ENV['MC_KEY'], ENV['MC_SECRET'] if Rails.env.production? or Rails.env.staging?
  provider :mailchimp, ENV['MailchimpCouponsMC_KEY'], ENV['MailchimpCouponsMC_SECRET'] if Rails.env.development?
end
