class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.references :language, null: false
      t.string :value, null: false
      t.references :also_written_as, foreign_key: { to_table: :words }

      t.index [:language_id, :value], unique: true

      t.timestamps
    end
  end
end
