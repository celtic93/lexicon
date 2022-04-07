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

    locale = exercise.locale.to_sym
    opposite_locale = { en: :ru, ru: :en }[locale]
    prev_correct_answers = user.last_round.exercises.correct
                               .where(opposite_locale => exercise[opposite_locale], locale: locale)
                               .pluck(locale)

    @result.messages.push(exercise[opposite_locale])
    @result.messages.push(prev_correct_answers_to_text(prev_correct_answers)) if prev_correct_answers.any?
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

  def prev_correct_answers_to_text(answers)
    answers.map!.with_index { |tr, i| "#{i + 1}. #{tr}" }
    answers.unshift('Правильные ответы ранее:').join("\n")
  end

  class Result
    attr_accessor :messages

    def initialize
      @messages = []
    end
  end
end
