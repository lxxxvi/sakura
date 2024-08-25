class Translation < ApplicationRecord
  belongs_to :word
  belongs_to :target_word, class_name: "Word"

  scope :latest, -> { order(created_at: :desc) }

  def twin
    Translation.find_by(word: target_word, target_word: word)
  end

  def destroy_with_twin
    twin&.destroy
    destroy
  end
end
