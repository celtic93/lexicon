class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :current_tg_user

  def start!(*)
    respond_with :message, text: "Привет #{current_tg_user.telegram_id}"
  end

  def message(message)
    respond_with :message, text: "#{message['text']}"
  end

  private

  def current_tg_user
    @current_tg_user ||= User.find_or_create_by(telegram_id: from['id'])
  end
end
