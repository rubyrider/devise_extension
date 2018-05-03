module DeviseExtension
  module CommonHelper
    def model_name(name)
      ActiveSupport::Inflector.underscore(name)
    end

    def pluralize_model_name(name)
      ActiveSupport::Inflector.pluralize(model_name(name))
    end

    def devise_exists?(name)
      File.readlines(model_path(name.downcase)).grep(/devise/) rescue false
    end

    def model_path(model_class_name)
      File.join("app", "models", "#{model_class_name}.rb")
    end

    def model_exists?(model_class_name)
      File.exist?(model_path(model_class_name))
    end

    def migration_exists?(table_name)
      Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_devise_extension_to_#{table_name}.rb$/).first
    end

    def postgresql?
      config = ActiveRecord::Base.configurations[Rails.env]
      config && config['adapter'] == 'postgresql'
    end

    def migration_version
      if rails5?
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end

    def primary_key_type
      primary_key_string if rails5?
    end

    def primary_key_string
      key_string = options[:primary_key_type]
      ", id: :#{key_string}" if key_string
    end

    def migration_path
      if Rails.version >= '5.0.3'
        db_migrate_path
      else
        @migration_path ||= File.join("db", "migrate")
      end
    end
  end
end

require_relative 'helpers/questionable_helper'