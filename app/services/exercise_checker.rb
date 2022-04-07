class ExerciseChecker
  def check_user_answer(user, answer)
    exercise = user.exercises.last
    locale = exercise.locale.to_sym
    result = Result.new

    if exercise[locale] == answer
      exercise.update(input: answer)
      exercise.correct!
      result.next_exercise = true
      result.messages.push('ПРАВИЛЬНО')
      return result
    end

    opposite_locale = { ru: :en, en: :ru }[locale]
    possible_answers = Word.where(locale: locale, opposite_locale => exercise[opposite_locale]).pluck(locale)

    if answer.in?(possible_answers)
      result.messages.push('ПРАВИЛЬНО, но нужен другой вариант')
      result.messages.push(exercise[opposite_locale])
      return result
    end

    input_traslations = Word.where(locale: locale, locale => answer).pluck(opposite_locale)
    exercise_traslations = Word.where(locale: opposite_locale, opposite_locale => exercise[opposite_locale]).pluck(locale)

    input_traslations_text = translations_to_text(input_traslations, answer)
    exercise_traslations_text = translations_to_text(exercise_traslations, exercise[opposite_locale])

    exercise.incorrect!
    user.last_round.failed!
    result.next_exercise = true
    result.messages.push(input_traslations_text)
    result.messages.push(exercise_traslations_text)
    result.messages.push("Загаданный перевод слова '#{exercise[opposite_locale]}' - #{exercise[locale]}")
    result
  end

  private

  def translations_to_text(translations, word)
    if translations.any?
      translations.map!.with_index { |tr, i| "#{i + 1}. #{tr}" }
      translations.unshift("Варианты перевода слова '#{word}'").join("\n")
    else
      "Переводов слова '#{word}' не найдено"
    end
  end

  class Result
    attr_accessor :messages, :next_exercise, :other_translation

    def initialize(next_exercise: false)
      @messages = []
      @next_exercise = next_exercise
    end

    def next_exercise?
      @next_exercise
    end
  end
end
