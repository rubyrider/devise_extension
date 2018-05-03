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
  
  test 'append devise_for questionable to devise class' do
    run_generator %w(user)
    match = /devise :questionable/
    assert_file "app/models/user.rb", match
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