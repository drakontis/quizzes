class TakenQuizzesController < ApplicationController
  before_action :authenticate_user!

  def create
    quiz = Quiz.find params[:quiz_id]
    taken_quiz = TakenQuiz.active_taken_quiz(quiz: quiz, user: current_user)

    if taken_quiz.present?
      redirect_to quiz_url(quiz, taken_quiz_id: taken_quiz.id)
    else
      taken_quiz = TakenQuiz.new(quiz: quiz, user: current_user)
      if taken_quiz.save
        redirect_to quiz_url(quiz, taken_quiz_id: taken_quiz.id)
      else
        flash[:error] = 'Something went wrong, please try again'
        redirect_to quizzes_url
      end
    end
  end

  def update
    @taken_quiz = TakenQuiz.find params['id']
    answer = Answer.new(secure_answer_params)

    if !(@taken_quiz.answers << answer)
      flash[:error] = 'Something went wrong, please try again later'
      redirect_to root_url
    elsif answer.question.last?
      flash[:notice] = 'Thank you!'
      redirect_to root_url
    end
  end

  private

  def secure_answer_params
    params.require(:taken_quiz).require(:answer).permit(:question_id, :choice_id)
  end
end
