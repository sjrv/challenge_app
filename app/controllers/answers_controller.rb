class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @question.answered?
      redirect_to question_path(@question), alert: "This question has already been answered."
    end

    if @answer.save
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def ajax
    resp = {}
    puts params
    answer = Answer.find(params[:answer_id])
    
    if current_user == answer.user
      render json: {errors: ['Tampering with code to like own answers? Really?']}
    end

    resp[:answer_id] = params[:answer_id]

    if params[:act] == 'like'
      if answer.liked_by? current_user
        answer.unlike current_user
        resp[:click] = "I like this answer!"
      else
        answer.like current_user
        resp[:click] = "I don't like it anymore."
      end
      
      resp[:count] = view_context.pluralize(answer.points,'like')
    elsif params[:act] == 'accept'
      if answer.accepted?
        answer.unaccept
        resp[:click] = "Accept this answer as satisfactory"
      else
        answer.accept
        resp[:click] = "I changed my mind, this answer is not good enough"
      end

      resp[:accepted] = answer.accepted?
    end

    render json: resp
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end
end
