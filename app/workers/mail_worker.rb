# app/workers/mailman.rb
class MailWorker
  include Sidekiq::Worker

  def perform task, id
  	case task
  	when :new then
  	  AnswersMailer.new_answer(id).deliver
  	when :accept then
      AnswersMailer.accept_answer(id).deliver
    end
  end
end
