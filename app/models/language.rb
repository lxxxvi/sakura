class Language < ApplicationRecord
  has_many :words, dependent: :destroy

  validates :iso, presence: true
  validates :iso, uniqueness: true

  scope :ordered_by_iso, -> { order(iso: :asc) }

  def to_param
    iso
  end
end
