class <%= DeviseExtension.question_able_model %> < <%= active_record_class %>
  belongs_to :<%= name.downcase.to_sym %>
end