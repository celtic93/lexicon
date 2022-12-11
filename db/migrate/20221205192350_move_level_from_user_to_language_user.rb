class MoveLevelFromUserToLanguageUser < ActiveRecord::Migration[7.0]
  def up
    users = User.all
    language = Language.where(name: 'English').first

    users.each do |user|
      LanguageUser.create(user_id: user.id, language_id: language.id, level: user.level)
    end

    remove_column :users, :level
  end

  def down
    add_column :users, :level, :integer, default: 1

    users = User.all
    language = Language.where(name: 'English').first

    users.each do |user|
      language_user = LanguageUser.where(user_id: user.id, language_id: language.id).first
      user.update(level: language_user.level)
    end

    LanguageUser.destroy_all
  end
end
