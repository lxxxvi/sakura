class WordsController < ApplicationController
  before_action :set_language

  def index
    @words = @language.words.latest.limit(10)
  end

  def show
    @word = @language.words.find_by!(value: params[:value])
  end

  def destroy
    @word = @language.words.find_by!(value: params[:value])

    @word.destroy

    redirect_to words_path(@word.language)
  end

  private

  def set_language
    @language = Language.find_by!(iso: params[:language_iso])
  end
end
