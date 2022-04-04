Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  root 'home#index'
end
