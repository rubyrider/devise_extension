require 'rails/generators'
require 'rails/generators/active_record/migration'

module DeviseExtension
  class QuestionableGenerator < ::Rails::Generators::NamedBase
    include ActiveRecord::Generators::Migration
    include DeviseExtension::QuestionableHelper

    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    class_option :primary_key_type, type: :string, desc: "The type for primary key"

    source_root File.expand_path('../templates', __FILE__)
    
    def copy_initializer
      template 'devise_extension.rb', "config/initializers/devise_extension.rb"
    end
    
    def copy_migration
      if (behavior == :invoke && model_exists?(model_name)) || (behavior == :revoke && migration_exists?(question_table))
        migration_template "migrations/migration_existing.rb", "#{migration_path}/add_devise_extension_to_#{question_model_file}.rb", migration_version: migration_version
      else
        migration_template "migrations/migration.rb", "#{migration_path}/devise_extension_create_#{question_model_file}.rb", migration_version: migration_version
      end
    end

    def migration_data
      <<-MIGRATION_DATA
      ## Database :questionable
      t.string :question,   null: false, default: ""
      t.string :answer, null: false, default: ""
      t.references :#{name.downcase}, index: true
      t.integer :state, null: false, default: 0
      t.datetime :deleted_at
      MIGRATION_DATA
    end
    
    def copy_model
      template "security_questionable.rb", "app/models/#{model_name}.rb"
    end
    
    def inject_questionable_content
      buffer = <<-CONTENT
  devise :questionable
      CONTENT
      
      if devise_exists?(name)
      else
        inject_into_class(model_path(name.downcase), "#{name.humanize}", buffer)
      end
    end
    
    def show_readme
      readme "README"
    end

    # Thanks to Devise
    def ip_column
      # Padded with spaces so it aligns nicely with the rest of the columns.
      "%-8s" % (inet? ? "inet" : "string")
    end

    def inet?
      postgresql?
    end

    def rails5?
      Rails.version.start_with? '5'
    end
    
  end
end

