class Word < ApplicationRecord
  belongs_to :language
  belongs_to :also_written_as, optional: true, class_name: "Word"

  has_many :translations, dependent: :destroy
  # has_many :translation_sources, dependent: :destroy, class_name: "Translation", inverse_of: :target_word

  validates :value, presence: true
  validates :value, uniqueness: { scope: :language_id }

  scope :latest, -> { order(created_at: :desc) }
  scope :of_iso, ->(iso) { where(language: Language.find_by(iso:)) }

  def to_param
    value
  end
end
