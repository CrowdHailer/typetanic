require_relative './../test_config'

module Typetanic
  class IntegerTest < MiniTest::Test


    def test_it
      puts Integer.new('  -34')
    end
  end
end
