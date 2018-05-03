module DeviseExtension
  module QuestionableHelper
    include CommonHelper
    
    def question_table
      DeviseExtension.question_able_model.tableize
    end
    
    def question_model_file
      ActiveSupport::Inflector.singularize(DeviseExtension.question_able_model.tableize)
    end

    def active_record_class
      DeviseExtension.rails51? ? 'ApplicationRecord' : 'ActiveRecord::Base'
    end

    def model_name(name = DeviseExtension.question_able_model)
      ActiveSupport::Inflector.underscore(name)
    end
  end
end