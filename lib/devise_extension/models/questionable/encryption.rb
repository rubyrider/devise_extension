module DeviseExtension
  module Models
    module Questionable
      module Encryption
        
        extend ActiveSupport::Concern
        
        included do
          before_create :encrypt_answer
        end
        
        module ClassMethods
          def verify_answer!(user_id, encryption_subject)
            self.find_by(
                user_id: user_id,
                answer:  digested_answer(encryption_subject)
            ).present?
          end
          
          # Can be override
          def digested_answer(encryption_subject)
            Digest::SHA2.hexdigest(encryption_subject)
          end
        end
        
        # Can be override
        def encryption_subject
          answer
        end
        
        def encrypt_answer
          encrypt!
        end
        
        private
        
        def encrypt!
          self.answer = Digest::SHA2.hexdigest(encryption_subject)
        end
      end
    end
  end
end