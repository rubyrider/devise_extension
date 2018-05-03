# frozen_string_literal: true

require 'test_helper'

module DeviseExtension
  class QuestionableTest < ::ActiveSupport::TestCase
    setup do
      @user = User.create(email: 'irfandhk@gmail.com')
    end
    
    test 'should have questionable_association' do
      assert @user.respond_to?(DeviseExtension.question_able_association.to_sym)
    end
  end
end