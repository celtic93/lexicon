class ExerciseCreator
  def create_new_exercise_for(user)
    @result = Result.new
    new_word_for(user)

    unless @exercise_word
      new_round_for(user)
      new_word_for(user)
    end

    exercise = user.exercises.create(
      en: @exercise_word.en,
      ru: @exercise_word.ru,
      locale: @exercise_word.locale,
      round_id: user.last_round.id,
      word_id: @exercise_word.id
    )

    opposite_locale = { en: :ru, ru: :en }[exercise.locale.to_sym]
    @result.messages.push(exercise[opposite_locale])
    @result
  end

  private

  def new_word_for(user)
    word_ids = user.last_round.exercises.correct.pluck(:word_id)
    words = Word.where(level: user.level).where.not(id: word_ids)
    @result.messages.push("Осталось #{words.count} слов до конца круга") if (words.length % 5).zero? && words.any?
    @exercise_word = words.sample
  end

  def new_round_for(user)
    unless user.last_round.failed?
      user.update(level: user.level + 1)
      user.last_round.successful!
      @result.messages.push("ПОЗДРАВЛЯЕМ! Вы закончили круг без ошибок и перешли на уровень #{user.level}")
    end

    user.rounds.create(level: user.level)
    @result.messages.push('Начало нового круга')
  end

  class Result
    attr_accessor :messages

    def initialize
      @messages = []
    end
  end
end
