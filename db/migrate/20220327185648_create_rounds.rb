class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds, comment: 'Аccumulates exercises with uniq words of a certain level' do |t|
      t.integer :level, comment: 'Words level'
      t.references :user, comment: 'Belongs to user'

      t.timestamps
    end
  end
end
