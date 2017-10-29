class TakenQuizzesController < ApplicationController
  before_action :authenticate_user!

  def create
    quiz = Quiz.find params[:quiz_id]
    taken_quiz = TakenQuiz.new(quiz: quiz, user: current_user)

    if taken_quiz.save
      redirect_to quiz_url(quiz, taken_quiz_id: taken_quiz.id)
    else
      flash[:error] = 'Something went wrong, please try again'
      redirect_to quizzes_url
    end
  end

  def update
  end
end
