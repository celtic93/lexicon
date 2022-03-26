class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, comment: 'Users table' do |t|
      t.integer :telegram_id, comment: "User's id in telegram"
      t.integer :level, default: 1, comment: "User's word level"

      t.timestamps
    end
  end
end
