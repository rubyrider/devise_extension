module Devise
  module Models
    module Questionable
      
      extend ActiveSupport::Concern
      
      included do
        has_many DeviseExtension.question_able_association.to_sym, class_name: DeviseExtension.question_able_model
      end
      
      def clear_security_questions!
        security_question_answers.map!(&:inactive!)
      end
      
      module ClassMethods
        Devise::Models.config(self, :question_able, :re_question_able, :use_question_template, :minimum_questions, :maximum_questions)
        
        [:question_able, :re_question_able, :use_question_template, :minimum_questions, :maximum_questions].each do |config_attr|
          define_method config_attr do
            unless instance_variable_get :"@#{config_attr}"
              instance_variable_set(:"@#{config_attr}", DeviseExtension.send(config_attr))
            end
          end
        end
      end
    end
  end
end