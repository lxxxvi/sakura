class ExerciseItem < ApplicationRecord
  belongs_to :exercise

  validates :position,
            :from_language_iso,
            :from_word_value,
            :to_language_iso,
            :possible_solutions,
            :score,
            presence: true

  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :position, uniqueness: { scope: :exercise_id }

  scope :ordered_by_position, -> { order(position: :asc) }
  # scope :answered, -> { where.not(given_answer: nil) }

  def answered?
    given_answer.present?
  end

  def answered_with(value)
    raise "Cannot answer again!" if given_answer.present?

    if value.present?
      given_answer = value
      score = given_answer.in?(possible_solutions) ? 100 : 0
      update(given_answer:, score:)
    else
      errors.add(:given_answer, :blank) && false
    end
  end

  def to_param
    url_identifier
  end
end
