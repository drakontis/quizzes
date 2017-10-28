class CreateTakenQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :taken_quizzes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :quiz, foreign_key: true, null: false
    end
  end
end
