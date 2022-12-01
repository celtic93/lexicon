class AddLanguageToWords < ActiveRecord::Migration[7.0]
  def up
    language = Language.create(name: 'English')
    Word.update_all(language_id: language.id)
  end
end
