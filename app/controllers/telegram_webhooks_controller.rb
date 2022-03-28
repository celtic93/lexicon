class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :current_tg_user

  def start!(*)
    new_exercise
  end

  def message(message)
    respond_with :message, text: message['text']
  end

  private

  def current_tg_user
    result = UserManager.new.find_or_create_by_telegram_id(from['id'].to_i)
    respond_with :message, text: 'ПОГНАЛИ' if result.new_user?
    @current_tg_user = result.user
  end

  def new_exercise
    result = ExerciseCreator.new.create_new_exercise_for(@current_tg_user)
    respond_with :message, text: result.message
  end
end
