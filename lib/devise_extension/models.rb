require 'pp'

require_relative 'models/update_counter'
require_relative 'models/questionable'
require_relative 'models/questionable/encryption'
require_relative 'models/questionable/validateable'

module DeviseExtension
  module Models
    include Devise::Models
    
    module Questionable
      module Attachment
        def self.apply!
          DeviseExtension.question_able_model.constantize.send :include, DeviseExtension::Models::Questionable::Encryption
          DeviseExtension.question_able_model.constantize.send :include, DeviseExtension::Models::Questionable::Validateable
        end
      end
    end
  end
end