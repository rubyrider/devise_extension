class SecurityQuestionAnswer < ApplicationRecord
  include DeviseExtension::Models::AnswerEncryption
  
  belongs_to :user

  enum state: [:active, :inactive]

  default_scope { active }
end