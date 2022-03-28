class ExerciseCreator
  def create_new_exercise_for(user)
    word_ids = user.last_round.exercises.correct.pluck(:word_id)
    exercise_word = Word.where.not(id: word_ids).sample
    exercise = user.exercises.create(
      en: exercise_word.en,
      ru: exercise_word.ru,
      locale: exercise_word.locale,
      round_id: user.last_round.id,
      word_id: exercise_word.id
    )
    Result.new(message: exercise[exercise.locale])
  end

  class Result
    attr_reader :message

    def initialize(message:)
      @message = message
    end
  end
end
