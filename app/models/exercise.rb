class Exercise < ApplicationRecord
  attr_readonly :url_identifier

  belongs_to :user

  has_many :exercise_items

  validates :started_at, presence: true
  validates :completion_percentage, :score_percentage, numericality: { greater_than_or_equal_to: 0,
                                                                       less_than_or_equal_to: 100 }

  scope :antichronical, -> { order(started_at: :desc) }

  def ended?
    ended_at.present?
  end

  def find_next_exercise_item
    exercise_items.ordered_by_position.find_by(given_answer: nil)
  end

  def update_progress
    all_exercise_items = exercise_items

    completion_percentage = 0
    score_percentage = 0
    ended_at = self.ended_at

    answered_items = all_exercise_items.find_all(&:answered?)

    if answered_items.any?
      completion_percentage =  answered_items.size * 100 / all_exercise_items.size
      score_percentage = answered_items.sum(&:score) / answered_items.size
    end

    if completion_percentage == 100
      ended_at ||= Time.zone.now
    end

    update(completion_percentage:, score_percentage:, ended_at:)
  end

  def to_param
    url_identifier
  end
end
