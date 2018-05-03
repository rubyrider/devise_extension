require_relative 'models/questionable'
require_relative 'models/answer_encryption'

module DeviseExtension
  module Models
    include Devise::Models
  end
end