class CreateTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :translations do |t|
      t.references :word, null: false, foreign_key: true
      t.references :target_word, null: false, foreign_key: { to_table: :words }

      t.timestamps
    end
  end
end
