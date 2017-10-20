class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.references :question, foreign_key: true, null: false
      t.string :statement, null: false

      t.timestamps
    end
  end
end
