class ExerciseManager
  def show_answer(user)
    exercise = user.exercises.last
    locale = exercise.locale.to_sym
    result = Result.new

    result.messages.push({
                           text: exercise[locale],
                           reply_markup: {
                             inline_keyboard: [
                               [
                                 { text: 'Correct', callback_data: 'correct' },
                                 { text: 'Wrong', callback_data: 'wrong' }
                               ]
                             ]
                           }
                         })
    result
  end

  def show_word_translations(user)
    exercise = user.exercises.last
    locale = exercise.locale.to_sym
    opposite_locale = { en: :ru, ru: :en }[locale]
    result = Result.new

    exercise.incorrect!
    user.last_round.failed!

    translations = Word.where(locale: opposite_locale, opposite_locale => exercise[opposite_locale]).pluck(locale)
    result.messages.push({ text: translations_to_text(translations, exercise[opposite_locale]) })
    result
  end

  private

  def translations_to_text(translations, word)
    translations.map!.with_index { |tr, i| "#{i + 1}. #{tr}" }
    translations.unshift("Варианты перевода слова '#{word}'").join("\n")
  end

  class Result
    attr_accessor :messages

    def initialize
      @messages = []
    end
  end
end
