class AnswersMailer < ActionMailer::Base
  def setup_mail aid
    answer = Answer.find(aid)
    @question = answer.question
    @answer = answer
  end

  def new_answer aid
    setup_mail aid
    message = {
      to: "#{@question.user.name} <#{@question.user.email}>",
      subject: "#{@question.title} - new answer by #{@answer.user.name}"
    }   
    mail message
  end

  def accept_answer aid
    setup_mail aid
    message = {
      to: @answer.user.email,
      subject: "Your answer to question '#{@question.title}' has been accepted"
    }

    mail message
  end
end
