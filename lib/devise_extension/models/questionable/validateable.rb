module DeviseExtension
  module Models
    module Questionable
      module Validateable
        
        extend ActiveSupport::Concern
        
        included do
          validates :question, :answer, presence: true
  
          enum state: [:active, :inactive]
  
          default_scope { active }

          scope :persisted, -> {where.not(primary_key => nil)}
        end
      end
    end
  end
end