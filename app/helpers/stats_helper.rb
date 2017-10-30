module StatsHelper
  def datasets_for(quiz, user=nil)
    datasets = []

    quiz.questions.each_with_index do |question, index|
      dataset = {label: "Question #{index+1}",
                 backgroundColor: colors[index],
                 borderColor: "black",
                 data: question_data(question, user)}

      datasets << dataset
    end

    datasets
  end

  def question_data(question, user=nil)
    if user.present?
      answers_in_taken_quizzes = user.taken_quizzes.where(quiz: question.quiz).all.map{|question| question.answers.map(&:id) }.flatten

      question.choices.map do |choice|
        choice.answers.select{ |answer| answers_in_taken_quizzes.include?(answer.id) }.count
      end
    else
      question.choices.map{ |choice| choice.answers.count }
    end
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
