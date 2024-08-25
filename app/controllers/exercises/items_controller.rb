class Exercises::ItemsController < ApplicationController
  before_action :set_exercise
  before_action :set_exercise_item

  def show
    redirect_to edit_exercise_item_path(@exercise, @exercise_item) if !@exercise_item.answered?

    @next_exercise_item = @exercise.find_next_exercise_item
  end

  def edit
    redirect_to exercise_item_path(@exercise, @exercise_item) if @exercise_item.answered?
  end

  def update
    if @exercise_item.answered_with(exercise_item_params[:given_answer])
      @exercise.reload.update_progress
      redirect_to exercise_item_path(@exercise, @exercise_item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def exercise_item_params
    params.require(:exercise_item).permit(:given_answer)
  end

  def set_exercise
    @exercise = current_user.exercises.find_by!(url_identifier: params[:exercise_url_identifier])
  end

  def set_exercise_item
    @exercise_item = @exercise.exercise_items.find_by!(url_identifier: params[:url_identifier])
  end
end
