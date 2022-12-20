class UserManager
  def find_or_create_by_telegram_id(telegram_id)
    user = User.find_by_telegram_id(telegram_id)
    result = Result.new(user: user)
    return result if user

    user = User.create(telegram_id: telegram_id)
    language_user = LanguageUser.create(user_id: user.id, language_id: 1)
    user.update(current_language_user_id: language_user.id)
    user.current_language_user.rounds.create(level: 4)
    result.user = user
    result.new_user = true
    result
  end

  class Result
    attr_accessor :user
    attr_writer :new_user

    def initialize(user:, new_user: false)
      @user = user
      @new_user = new_user
    end

    def new_user?
      @new_user
    end
  end
end
