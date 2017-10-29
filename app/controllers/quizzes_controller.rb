class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find params[:id]
    @taken_quiz = TakenQuiz.find params[:taken_quiz_id]
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'To answer questions, please take a quiz'
    redirect_to quizzes_url
  end
end
