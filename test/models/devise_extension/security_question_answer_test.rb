# frozen_string_literal: true

require 'test_helper'

module DeviseExtension
  class SecurityQuestionAnswerTest < ::ActiveSupport::TestCase
    setup do
      @user = User.create!(email: 'irfandhk@gmail.com', password: 'passw0rd')
      @question = @user.security_question_answers.create!(
          question: 'What is your name',
          user_answer: 'My name is Rubyrider!'
      )
    end
    
    test 'should have security question answers' do
      refute @user.security_question_answers.count.zero?
    end
    
    test 'should have answer encrypted' do
      refute @question.answer.blank?
      
      assert SecurityQuestionAnswer.verify_answer!(@user.id, 'My name is Rubyrider!').present?
    end
  end
end