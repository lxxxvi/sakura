class CreateLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :languages do |t|
      t.string :iso, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
