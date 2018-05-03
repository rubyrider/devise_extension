class <%= DeviseExtension.question_able_model %> < <%= active_record_class %>
  include DeviseExtension::Models::AnswerEncryption
  
  belongs_to :<%= name.downcase.to_sym %>

  enum state: [:active, :inactive]

  default_scope { active }
end