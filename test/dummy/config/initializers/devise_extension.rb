DeviseExtension.setup do |config|
  # Minimum questions count
  config.minimum_questions = 3
  
  # Maximum questions count
  config.maximum_questions = 10
  
  config.use_question_template = true
  
  config.question_able_model = 'SecurityQuestionAnswer'
end