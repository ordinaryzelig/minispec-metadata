require 'minispec-metadata'

ActiveSupport.on_load(:active_support_test_case) do
  ActiveSupport::TestCase.include MinispecMetadata::It
end
