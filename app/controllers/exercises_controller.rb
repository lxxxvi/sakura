class ExercisesController < ApplicationController
  def index
    @exercises = current_user.exercises.antichronical
  end

  def show
    @exercise = current_user.exercises.find_by!(url_identifier: params[:url_identifier])
  end

  def create
    exercise = current_user.exercises.new(started_at: Time.zone.now)

    Translation.where(word: Word.of_iso("en"), target_word: Word.of_iso("ja"))
               .sample(5)
               .each_with_index do |translation, index|
      possible_solutions = Word.where(id: translation.word.translations.where(target_word: Word.of_iso("ja")).select(:target_word_id)).pluck(:value)

      exercise.exercise_items.new(
        position: index,
        from_language_iso: "en",
        from_word_value: translation.word.value,
        to_language_iso: "ja",
        possible_solutions:
      )
    end

    exercise.save

    redirect_to exercise_path(exercise)
  end
end
