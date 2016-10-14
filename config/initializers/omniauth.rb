Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV.fetch('slack_api_key'), ENV.fetch('slack_secret'), scope: 'identity.basic', name: :sign_in_with_slack
  provider :slack, ENV.fetch('slack_api_key'), ENV.fetch('slack_secret'), scope: 'identify'
end
