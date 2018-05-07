require "devise_extension/engine"
require 'active_record'
require 'active_support/all'
require 'rails/railtie'
require 'devise'
require 'devise_extension/helpers'
require 'generators/questionable/questionable_generator'
require 'devise_extension/models'
require 'pp'

module DeviseExtension
  include Devise
  
  # Minimum questions count
  mattr_accessor :minimum_questions
  @@minimum_questions = 3
  
  # Maximum questions count
  mattr_accessor :maximum_questions
  @@maximum_questions = 10
  
  mattr_accessor :question_able
  @@question_able = true
  
  mattr_accessor :re_question_able
  @@re_question_able = false
  
  mattr_accessor :use_question_template
  @@use_question_template = true
  
  mattr_accessor :question_able_model
  @@question_able_model = 'SecurityQuestionAnswer'

  mattr_accessor :question_able_association
  @@question_able_association = DeviseExtension.question_able_model.tableize
  
  def self.rails51? # :nodoc:
    Rails.gem_version >= Gem::Version.new("5.1.x")
  end
  
  def self.setup
    yield self
  end

  Devise.add_module(:questionable,  controller: :questions, model: 'devise_extension/models/questionable')
end