# Multiple-Choice Quizzes

This is a Rails coding exercise. The goal is to improve a simple app that administers quizzes and allows users to take and review those quizzes.

Each quiz is composed of several questions. Each of these questions contains multiple answer choices. We've included basic models and a DB schema to support this basic data.

This starting point includes RSpec for testing, Devise for authentication, ActiveAdmin for administration interface (available at /admin), and Bootstrap as the CSS framework for the non-admin UI.

Specs can be run with `rspec`. All existing tests are passing.

## Rules

* Please do not make your code public.
* Please write clear commit messages.
* You can ask us for clarification on the described features. We'll try to answer in the same manner as a typical stakeholder.
* Working code is better than perfect code.
* Maintainable code is better than magic.
* The UI design is not too important at this stage. That being said, [Twitter Bootstrap 3](https://getbootstrap.com/docs/3.3/) is already available, so you can leverage it.

## Time

You have 72 hours to work on this. We understand you might not be able to deliver all the features but the more, the better.

## Requirements

This list is in no particular order. Use your best judgment to prioritize.

* Users should be able to see a list of quizzes at /quizzes. Each quiz should have a “Take” option. Include a link to this page in the main app's navigation bar.
* Each user can take the same quiz an unlimited number of times, and all attempts should be stored in the database.
* When clicking to take a quiz, the user should be presented with one question at a time. Below the question, all the possible answer choices should be listed.
* The user can select only one answer choice per question.
* When a user is viewing a question, the user should see a “Next” button. That button, when clicked, should submit the selected answer choice and display the next question.
* After the user has submitted the last question, the quiz attempt should be considered submitted, and the user should be redirected back to the quizzes index.
* Include some automated tests.
* The user shouldn't be able to move to the next question until he or she selects an answer choice.
* Write a rake task to import questions from the [Open Trivia DB](https://opentdb.com/) using the following endpoint: https://opentdb.com/api.php?amount=50&type=multiple. Remember: we don't care about which answer is correct or the question's category or difficulty.

## Optional

This list is in no particular order. Use your judgment to prioritize.

* Include some automated feature tests using capybara.
* Include a “Stats” option for each quiz right next to the “Take” option. Quiz stats should show a graph for each question's choice counts. Stats should include data only from submitted attempts for all users.
* Use AJAX to submit answer choices and render the next question.
* When displaying a quiz's stats, somehow highlight the current user's answer choice for each question.
* Only admins should be able use the admin interface.
