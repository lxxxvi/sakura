class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :url_identifier, null: false, default: -> { "lower(hex(randomblob(5)))" }
      t.references :user, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at, null: true
      t.integer :completion_percentage, null: false, default: 0
      t.integer :score_percentage, null: false, default: 0

      t.index [:user_id, :url_identifier], unique: true

      t.timestamps
    end
  end
end
