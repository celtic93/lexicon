class RenameWordEnToNative < ActiveRecord::Migration[7.0]
  def up
    rename_column :words, :en, :native
    change_column :words, :native, :string, comment: 'Associate language word translation'
    rename_column :exercises, :en, :native
    change_column :exercises, :native, :string, comment: 'Word language word translation'
  end

  def down
    rename_column :words, :native, :en
    rename_column :exercises, :native, :en
  end
end
