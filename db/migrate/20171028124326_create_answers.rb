class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :taken_quiz, foreign_key: true, null: false
      t.references :question,   foreign_key: true, null: false
      t.references :choice,     foreign_key: true, null: false
    end
  end
end
