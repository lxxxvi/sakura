class TranslationForm
  include ActiveModel::Model

  attr_reader :params

  validates :source_word_language_iso, :source_word_value,
            :target_word_language_iso, :target_word_value,
            presence: true
  validates :source_word_language_iso,
            comparison: { other_than: :target_word_language_iso },
            if: -> { source_word_language_iso.present? && target_word_language_iso.present? }

  def initialize(params:)
    @params = params
  end

  def source_word_language_iso
    translation_params[:source_word_language_iso]
  end

  def source_word_value
    translation_params[:source_word_value]
  end

  def target_word_language_iso
    translation_params[:target_word_language_iso]
  end

  def target_word_value
    translation_params[:target_word_value]
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Translation")
  end

  def target_word_language_options
    @target_word_language_options ||= Language.pluck(:iso)
  end

  def save
    return false unless valid?

    Translation.find_or_create_by(word: source_word, target_word:)
    Translation.find_or_create_by(word: target_word, target_word: source_word)
  end

  def source_word_language
    @source_word_language ||= Language.find_by!(iso: translation_params[:source_word_language_iso])
  end

  def source_word
    @word ||= source_word_language.words.find_or_initialize_by(value: translation_params[:source_word_value])
  end

  private

  def translation_params
    return {} if !params.key?(:translation)

    params.require(:translation)
          .permit(:source_word_language_iso, :source_word_value,
                  :target_word_language_iso, :target_word_value)
  end

  def target_word_language
    @target_word_language ||= Language.find_by!(iso: translation_params[:target_word_language_iso])
  end

  def target_word
    @target_word ||= target_word_language.words.find_or_initialize_by(value: translation_params[:target_word_value])
  end
end
