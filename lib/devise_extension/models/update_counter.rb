module DeviseExtension
  module Models
    module UpdateCounter
      extend ActiveSupport::Concern
      
      attr_accessor :old_questions
      
      included do
        before_save :inactive_old_questions_if_require
        before_save :preserve_old_questions
        after_save :update_counter
      end
      
      def sqa_update_timestamp
        self.last_question_updated_at = Time.zone.now
      end
      
      def sqa_update_timestamp!
        sqa_update_timestamp && save
      end
      
      def sqa_update_counter
        self.question_answer_total_update_count += 1
      end
      
      def sqa_update_counter!
        sqa_update_counter && save
      end
      
      def mark_sqa_required(clean_old_questions = false)
        self.reset_question_answer = true
      end
      
      def mark_sqa_required!(clean_old_questions = false)
        clear_security_questions! if defined?(:clear_security_questions!) && clean_old_questions
        
        mark_sqa_required && save
      end
      
      def unmark_sqa_required
        self.reset_question_answer = false
      end
      
      def unmark_sqa_required!
        unmark_sqa_required && save
      end
      
      private
      
      def inactive_old_questions_if_require
        if reset_question_answer_changed? && reset_question_answer
          clear_security_questions!
        end
      end
      
      def preserve_old_questions
        if send("#{::DeviseExtension.question_able_association}").map(&:new_record?).present?
          self.old_questions = self.security_question_answers.select(&:persisted?)
        end
      end
      
      def update_counter
        if self.old_questions.present?
          sqa_update_timestamp
          sqa_update_counter
          unmark_sqa_required
          
          update_columns(
              last_question_updated_at:           self.last_question_updated_at,
              question_answer_total_update_count: self.question_answer_total_update_count,
              reset_question_answer:              self.reset_question_answer
          )
          
          self.old_questions.map!(&:inactive!)
        end
      end
    end
  end
end