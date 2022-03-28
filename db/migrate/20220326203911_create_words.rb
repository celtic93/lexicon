class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words, comment: 'Words table' do |t|
      t.string :en, comment: 'English word translation'
      t.string :ru, comment: 'Russian word translation'
      t.integer :level, comment: 'Word level'
      t.integer :rank, comment: "Word rank in 'Frequency lists/PG/2006/04'"

      t.timestamps
    end
  end
end
