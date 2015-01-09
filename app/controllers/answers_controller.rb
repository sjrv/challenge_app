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
      puts "SENDING".cyan
      #puts MailWorker.perform_async(:new, @answer.id)
      puts AnswersMailer.delay.new_answer(@answer.id)
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def accept
    answer = Answer.find(params[:answer_id])
    puts "Answer:"
    puts answer
    if answer.accepted
      redirect_to question_path(@question), alert: "This answer has already been accepted."
    else
      answer.accept
      mail = AnswersMailer.accept_answer(@answer.id)
      puts "MAIL:".yellow
      puts mail
      puts "SENDING".cyan
      puts mail.deliver!
      puts "SENT".cyan
      redirect_to question_path(@question)
    end
  end

  def like
    resp = {}
    #puts "PARAMS"
    #puts params
    answer = Answer.find(params[:answer_id])
    
    resp[:answer_id] = params[:answer_id]

    if answer.liked_by? current_user
      answer.unlike current_user
      resp[:click] = "Like"
    else
      answer.like current_user
      resp[:click] = "I don't like it anymore."
    end

    resp[:count] = view_context.pluralize(answer.points,'like')
    #puts "RESPONSE"
    #puts resp
    render json: resp
  end

  private

    def set_question
      #puts "PARAMS:"
      #puts params
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end
end
