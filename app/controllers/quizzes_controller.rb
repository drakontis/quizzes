class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find params[:id]
    @taken_quiz = TakenQuiz.find params[:taken_quiz_id]
  end
end
