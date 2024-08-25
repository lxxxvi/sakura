class TranslationsController < ApplicationController
  def new
    @form = TranslationForm.new(params:)
  end

  def create
    @form = TranslationForm.new(params:)

    if @form.save
      redirect_to word_path(@form.source_word.language, @form.source_word)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @translation = Translation.find(params[:id])

    @translation.destroy_with_twin

    redirect_to word_path(@translation.word.language, @translation.word)
  end
end
