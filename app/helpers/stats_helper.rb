module StatsHelper
  def datasets_for(quiz)
    datasets = []

    quiz.questions.each_with_index do |question, index|
      dataset = {label: "Question #{index+1}",
                 backgroundColor: colors[index],
                 borderColor: "black",
                 data: question_data(question)}

      datasets << dataset
    end

    datasets
  end

  def question_data(question)
    question.choices.map{ |choice| choice.answers.count }
  end

  def colors
    ['green',
     'red',
     'blue',
     'yellow',
     'orange',
     'grey',
     'PaleVioletRed',
     'LawnGreen',
     'Indigo',
     'RoyalBlue']
  end
end
