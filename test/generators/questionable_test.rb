require 'test_helper'

class QuestionableTest < ::Rails::Generators::TestCase
  tests DeviseExtension::QuestionableGenerator
  
  destination File.expand_path("../rails_app", File.dirname(__FILE__))
  
  setup do
    prepare_destination
    copy_resources kind: :user
  end
  
  test "generates devise_extension_configuration" do
    run_generator %w(user)
    assert_file "config/initializers/devise_extension.rb"
  end
  
  test "generates security question answer model" do
    run_generator %w(user)
    assert_file "app/models/#{model_name}.rb"
  end
  
  test "generates new column migration for user" do
    run_generator %w(user)
    assert_migration "db/migrate/add_questionable_fields_to_users.rb", /t.boolean :reset_question_answer, default: true/
    assert_migration "db/migrate/add_questionable_fields_to_users.rb", /t.datetime :last_question_updated_at/
    assert_migration "db/migrate/add_questionable_fields_to_users.rb", /t.integer :question_answer_total_update_count, default: 0/
  end
  
  test 'append devise_for questionable to devise class' do
    run_generator %w(user)
    assert_file "app/models/user.rb", /devise :questionable/
  end
  
  private
  
  def copy_resources(kind: :user)
    case kind
      when :user
        if File.exist?("#{File.expand_path("../rails_app", File.dirname(__FILE__))}/app/models/user.rb")
          FileUtils.rm("#{File.expand_path("../rails_app", File.dirname(__FILE__))}/app/models/user.rb")
        end
        
        FileUtils.makedirs(
            "#{File.expand_path("../rails_app", File.dirname(__FILE__))}/app/"
        )
        
        FileUtils.makedirs(
            "#{File.expand_path("../rails_app", File.dirname(__FILE__))}/app/models"
        )
        
        FileUtils.cp(
            "#{File.expand_path('../resources', File.dirname(__FILE__))}/user.rb",
            "#{File.expand_path("../rails_app", File.dirname(__FILE__))}/app/models/"
        )
    end
  end
end