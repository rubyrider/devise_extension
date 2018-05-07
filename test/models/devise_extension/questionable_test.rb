# frozen_string_literal: true

require 'test_helper'

module DeviseExtension
  class QuestionableTest < ::ActiveSupport::TestCase
    setup do
      @user = User.create!(email: 'irfandhk@gmail.com', password: 'passw0rd')
    end
    
    test 'should have questionable_association' do
      assert @user.respond_to?(DeviseExtension.question_able_association.to_sym)
    end
  end
  
  class WhenQuestionRequiredToSetTest < ::ActiveSupport::TestCase
    setup do
      @user     = User.create!(
          email:                 'irfandhk@gmail.com',
          password:              'passw0rd',
          reset_question_answer: false
      )
      @question = @user.security_question_answers.create!(
          question: 'What is your name',
          answer:   'My name is Rubyrider!'
      )
    end
    
    test 'should have security question answers' do
      refute @user.security_question_answers.count.zero?
    end
    
    test 'should remove when questions answer is requested to set' do
      assert_difference 'SecurityQuestionAnswer.unscoped.inactive.count' do
        @user.update_attributes(reset_question_answer: true)
        
        assert @user.reload.security_question_answers.count.zero?
      end
    end
  end
  
  class NewQuestionAnswerSetTest < ::ActiveSupport::TestCase
    setup do
      @user = User.create!(
          email:                 'irfandhk@gmail.com',
          password:              'passw0rd',
          reset_question_answer: false
      )
      
      @question = @user.security_question_answers.create([
                                                             {
                                                                 question: 'What is your name (old)',
                                                                 answer:   'My name is Irfan'
                                                             },
                                                             {
                                                                 question: 'What is your father\'s name (old)',
                                                                 answer:   'His name is Rizvi'
                                                             },
                                                             {
                                                                 question: 'What is your mother\'s name (old)',
                                                                 answer:   'Her name is Hashi!'
                                                             },
                                                             {
                                                                 question: 'What is your wife\'s name (old)',
                                                                 answer:   'Her name is Purobi!'
                                                             },
                                                             {
                                                                 question: 'What is your older cat\'s name (old)',
                                                                 answer:   'His name is Guddu!'
                                                             },
                                                             {
                                                                 question: 'What is your younger cat\'s name (old)',
                                                                 answer:   'His name is Pingu!'
                                                             },
                                                             {
                                                                 question: 'What is your team lead\'s name (old)',
                                                                 answer:   'Hi name is Sajjib Hassan'
                                                             },
                                                             {
                                                                 question: 'What is your chief architect\'s name (old)',
                                                                 answer:   'His name is Syed Sami Uzzaman!'
                                                             }
                                                         ]
      )
    end
    
    test 'should have security question answers' do
      refute @user.security_question_answers.count.zero?
    end
    
    test 'should remove when questions answer is requested to set' do
      assert_difference 'SecurityQuestionAnswer.unscoped.inactive.count', 8 do
        @questions = @user.update_attributes(
            security_question_answers_attributes: ([
                {
                    question: 'What is your name',
                    answer:   'My name is Irfan'
                },
                {
                    question: 'What is your father\'s name',
                    answer:   'His name is Rizvi'
                },
                {
                    question: 'What is your mother\'s name',
                    answer:   'Her name is Hashi!'
                },
                {
                    question: 'What is your wife\'s name',
                    answer:   'Her name is Purobi!'
                },
                {
                    question: 'What is your older cat\'s name',
                    answer:   'His name is Guddu!'
                },
                {
                    question: 'What is your younger cat\'s name',
                    answer:   'His name is Pingu!'
                },
                {
                    question: 'What is your team lead\'s name',
                    answer:   'Hi name is Sajjib Hassan'
                },
                {
                    question: 'What is your chief architect\'s name',
                    answer:   'His name is Syed Sami Uzzaman!'
                }
            ])
        )
      end
    end
  end
end