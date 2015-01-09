class AnswersMailer < ActionMailer::Base
  default from: "sjorvv@gmail.com"
  
  #include Resque::Mailer

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
  	puts "SENDING MAIL".blue
  	puts message
  	m = mail message
  	puts "MAIL".red
  	puts m
  	m
  end

  def accept_answer aid
  	setup_mail aid
  	message = {
  		to: @answer.user.email,
  		subject: "Your answer to question '#{@question.title}' has been accepted"
  	}

  	puts "SENDING MAIL".blue
  	puts message
  	m = mail message
  	puts "MAIL".red
  	puts m
  	m
  end
end
