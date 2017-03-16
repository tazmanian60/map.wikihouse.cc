class ChatNotifier
  cattr_accessor :default

  def initialize(backend)
    @backend = backend
  end

  def place_created(place)
    notify "#{place.name} (#{place.type}) added #{urls.admin_review_url(place)}"
  end

  private

  def notify(message)
    @backend.call message
  rescue => e
    logger.error e.message
  end

  def logger
    Rails.logger
  end

  def urls
    Rails.application.routes.url_helpers
  end
end

if webhook = ENV['slack_webhook_url']
  ChatNotifier.default = ChatNotifier.new(Slack::Notifier.new(webhook).method(:ping))
else
  ChatNotifier.default = ChatNotifier.new(Rails.logger.method(:info))
end
