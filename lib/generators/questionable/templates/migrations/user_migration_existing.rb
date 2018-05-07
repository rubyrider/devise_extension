# frozen_string_literal: true

class AddQuestionableFieldsTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def self.up
    change_table :<%= table_name %> do |t|
      t.boolean :reset_question_answer, default: true
      t.datetime :last_question_updated_at
      t.integer :question_answer_total_update_count, default: 0
    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.

    raise ActiveRecord::IrreversibleMigration
  end
end
