class CreateLanguage < ActiveRecord::Migration[7.0]
  def change
    create_table :languages, comment: 'Keeps connection with all words of its language' do |t|
      t.string :name, null: false, comment: 'language name'

      t.timestamps
    end

    add_reference :words, :language, index: true, comment: 'Belongs to language'
  end
end
