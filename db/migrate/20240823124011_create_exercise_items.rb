class CreateExerciseItems < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_items do |t|
      t.string :url_identifier, null: false, default: -> { "lower(hex(randomblob(2)))" }
      t.references :exercise, null: false, foreign_key: true
      t.integer :position, null: false
      t.string :from_language_iso, null: false
      t.string :from_word_value, null: false
      t.string :to_language_iso, null: false
      t.json :possible_solutions, null: false
      t.string :given_answer, null: true
      t.integer :score, null: false, default: 0

      t.index [:exercise_id, :url_identifier], unique: true
      t.index [:exercise_id, :position], unique: true

      t.timestamps
    end
  end
end
