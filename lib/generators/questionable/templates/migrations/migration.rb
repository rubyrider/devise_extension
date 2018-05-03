# frozen_string_literal: true

class DeviseExtensionCreate<%= DeviseExtension.question_able_model %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= DeviseExtension.question_able_model.tableize %><%= primary_key_type %> do |t|
<%= migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end
  end
end