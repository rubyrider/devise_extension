module Devise
  module Models
    module Questionable
      extend ActiveSupport::Concern
      
      included do
        has_many ::DeviseExtension.question_able_association.to_sym, class_name: ::DeviseExtension.question_able_model

        accepts_nested_attributes_for ::DeviseExtension.question_able_association.to_sym, reject_if: :all_blank, allow_destroy: true

        validates_associated ::DeviseExtension.question_able_association.to_sym
        
        include ::DeviseExtension::Models::UpdateCounter

        ::DeviseExtension::Models::Questionable::Attachment.apply!
      end
      
      def clear_security_questions!
        send(::DeviseExtension.question_able_association.to_sym).map(&:inactive!)
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