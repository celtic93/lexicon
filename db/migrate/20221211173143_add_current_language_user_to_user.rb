class AddCurrentLanguageUserToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :current_language_user, foreign_key: { to_table: :language_users },
                                                  comment: 'Belongs to current language'
  end
end
