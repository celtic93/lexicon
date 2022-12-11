class SetCurrentLanguageUserToUsers < ActiveRecord::Migration[7.0]
  def up
    User.all.each do |user|
      if user.current_language_user.nil?
        current_language_user = LanguageUser.where(user_id: user.id).first
        user.update(current_language_user_id: current_language_user.id)
      end
    end
  end
end
