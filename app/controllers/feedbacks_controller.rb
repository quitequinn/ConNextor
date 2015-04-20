class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback.user_to_task.project }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback.user_to_task.project }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @feedback.destroy
    respond_to do |format|
      # change redirection
      format.html { redirect_to root_url, notice: 'feedback was successfully destroyed.' }
    end
  end

  private
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(
        :feedback_creator,
        :rating,
        :feedback,
        :user_to_task
        )
    end

end