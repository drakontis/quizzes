ActiveAdmin.register Quiz do
  permit_params :title,
    questions_attributes: [
      :id, :quiz_id, :prompt, :_destroy,
      choices_attributes: [
        :id, :statement, :_destroy
      ]
    ]

  form do |f|
    f.semantic_errors

    f.inputs 'Details', :title

    f.has_many :questions, heading: 'Questions', allow_destroy: true do |question_f|
      question_f.input :prompt

      question_f.has_many :choices, heading: 'Choices', allow_destroy: true do |choice_f|
        choice_f.input :statement
      end
    end

    f.actions
  end
end
