module DeviseExtension
  module Models
    module AnswerEncryption
      
      extend ActiveSupport::Concern

      included do
        attr_accessor :user_answer
  
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
        user_answer
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