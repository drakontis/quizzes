Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  devise_for :quizzes
  ActiveAdmin.routes(self)
  resources :users

  resources :quizzes, only: ['index', 'show']
  resources :taken_quizzes, only: ['create', 'update']
end
