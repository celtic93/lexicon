Rails.application.routes.draw do
  resources :words
  telegram_webhook TelegramWebhooksController

  root 'home#index'
end
