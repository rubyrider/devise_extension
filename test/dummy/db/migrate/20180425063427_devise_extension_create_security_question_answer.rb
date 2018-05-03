# frozen_string_literal: true

class DeviseExtensionCreateSecurityQuestionAnswer < ActiveRecord::Migration[5.1]
  def change
    create_table :security_question_answers do |t|
      ## Database :questionable
      t.string :question,   null: false, default: ""
      t.string :answer, null: false, default: ""
      t.references :user, index: true
      t.integer :state, null: false, default: 0
      t.datetime :deleted_at

      t.integer :question_template_id

      t.timestamps null: false
    end
  end
end