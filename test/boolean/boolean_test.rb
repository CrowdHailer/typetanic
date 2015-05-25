require_relative './../test_config'

module Typetanic
  class BooleanTest < MiniTest::Test


    def test_
      klass = Typetanic::Boolean(affirmative: ['1'], negative: ['0'])
      klass.new('1')
      klass.new('0')
      # puts klass.new('other')
    end
  end
end
