class CreateLanguageUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :language_users, comment: 'Keeps user progress by languages and other settings' do |t|
      t.references :language, comment: 'Belongs to language'
      t.references :user, comment: 'Belongs to user'
      t.integer :level, default: 1, comment: "User's word level"

      t.timestamps
    end
  end
end
