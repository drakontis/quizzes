class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find params[:id]
  end
end
