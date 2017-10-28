namespace :quizzes do
  desc 'Populates the database with quizzes using questions from https://opentdb.com/api.php?amount=50&type=multiple. Each 10 questions will compose a new test'
  task load: :environment do
    require 'net/http'

    def create_choices(question_json)
      choices = []

      choices << Choice.new(statement: question_json['correct_answer'])
      question_json['incorrect_answers'].each do |statement|
        choices << Choice.new(statement: statement)
      end

      choices.shuffle # We shuffle the answer in order the correct answer not to be always first.
    end

    url = URI.parse('https://opentdb.com/api.php?amount=50&type=multiple')
    response = Net::HTTP.get(url)
    questions = JSON.parse(response)['results']

    questions.in_groups_of(10) do |group|
      quiz = Quiz.new(title: "Quiz #{Quiz.last.try(:id).to_i + 1}")

      group.each do |question_json|
        question = Question.new(prompt: question_json['question'], choices: create_choices(question_json))

        quiz.questions << question
      end

      quiz.save!
    end
  end
end
