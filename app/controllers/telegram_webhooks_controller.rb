class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :current_tg_user

  def start!(*)
    new_exercise
  end

  def message(message)
    result = ExerciseChecker.new.check_user_answer(@current_tg_user, message['text'].downcase)
    respond_with_messages(result)
    new_exercise if result.next_exercise?
  end

  private

  def current_tg_user
    result = UserManager.new.find_or_create_by_telegram_id(from['id'].to_i)
    respond_with :message, text: 'ПОГНАЛИ' if result.new_user?
    @current_tg_user = result.user
  end

  def new_exercise
    return respond_with :message, text: 'КОНЕЦ' if @current_tg_user.level > Word.maximum(:level)

    result = ExerciseCreator.new.create_new_exercise_for(@current_tg_user)
    respond_with_messages(result)
  end

  def respond_with_messages(result)
    result.messages.each do |result_message|
      respond_with :message, text: result_message
    end
  end
end
