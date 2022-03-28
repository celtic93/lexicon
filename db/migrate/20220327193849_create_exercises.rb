class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises, comment: 'Exercise table' do |t|
      t.string :en, comment: 'English word translation'
      t.string :ru, comment: 'Russian word translation'
      t.string :input, comment: 'User input'
      t.integer :status, default: 0, comment: 'Status of exercise depending on user input'
      t.integer :locale, comment: 'Locale of exercise for user input'
      t.references :user, comment: 'Belongs to user'
      t.references :word, comment: 'Belongs to word'
      t.references :round, comment: 'Belongs to round'

      t.timestamps
    end
  end
end
