class ExerciseCreator
  def create_new_exercise_for(user)
    @result = Result.new
    new_word_for(user)

    unless @exercise_word
      new_round_for(user)
      new_word_for(user)
    end

    exercise = user.exercises.create(
      native: @exercise_word.native,
      ru: @exercise_word.ru,
      locale: @exercise_word.locale,
      round_id: user.last_round.id,
      word_id: @exercise_word.id
    )

    locale = exercise.locale.to_sym
    opposite_locale = { native: :ru, ru: :native }[locale]

    prev_correct_answers = user.last_round.exercises.correct
                               .where(opposite_locale => exercise[opposite_locale], locale: locale)
                               .pluck(locale)

    exercise_text = "#{exercise[opposite_locale]}"\
                    "#{prev_correct_answers_to_text(prev_correct_answers) if prev_correct_answers.any?}"

    @result.messages.push({
                            text: exercise_text,
                            reply_markup: {
                              inline_keyboard: [
                                [
                                  { text: 'Show answer', callback_data: 'show_answer' }
                                ]
                              ]
                            }
                          })
    @result
  end

  private

  def new_word_for(user)
    word_ids = user.last_round.exercises.correct.pluck(:word_id)
    words = user.language.words.where(level: user.level).where.not(id: word_ids)
    if (words.length % 5).zero? && words.any?
      @result.messages.push({ text: "Осталось #{words.count} слов до конца круга" })
    end
    @exercise_word = words.sample
  end

  def new_round_for(user)
    unless user.last_round.failed?
      user.current_language_user.update(level: user.level + 1)
      user.last_round.successful!
      @result.messages.push({ text: "ПОЗДРАВЛЯЕМ! Вы закончили круг без ошибок и перешли на уровень #{user.level}" })
    end

    user.current_language_user.rounds.create(level: user.level)
    @result.messages.push({ text: 'Начало нового круга' })
  end

  def prev_correct_answers_to_text(answers)
    answers.map!.with_index { |tr, i| "#{i + 1}. #{tr}" }
    answers.unshift("\n\nПравильные ответы ранее:").join("\n")
  end

  class Result
    attr_accessor :messages

    def initialize
      @messages = []
    end
  end
end
