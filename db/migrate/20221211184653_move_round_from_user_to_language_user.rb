class MoveRoundFromUserToLanguageUser < ActiveRecord::Migration[7.0]
  def up
    add_reference :rounds, :language_user, index: true, comment: 'Belongs to language_user'

    Round.all.each do |round|
      if round.language_user_id.nil?
        language_user_id = User.find(round.user_id).current_language_user.id
        round.update(language_user_id: language_user_id)
      end
    end

    remove_reference :rounds, :user
  end

  def down
    add_reference :rounds, :user, index: true, comment: 'Belongs to user'

    Round.all.each do |round|
      if round.user_id.nil?
        user_id = LanguageUser.find(round.language_user_id).user_id
        round.update(user_id: user_id)
      end
    end

    remove_reference :rounds, :language_user
  end
end
