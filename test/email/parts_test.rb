require_relative './../test_config'

module Typetanic
  class EmailTest < MiniTest::Test
    def example_string
      @example_string ||= 'test@example.com'
    end

    def example_email
      @example_email ||= Email.new example_string
    end

    def test_separates_local_part
      assert_equal 'test', example_email.local_part
    end

    def test_separates_hostname
      assert_equal 'example.com', example_email.hostname
    end

    # def test_separates_domains
    #   assert_equal ['com', 'example'], example_email.domains
    # end
    #
    # def test_fetch_top_level_domain
    #   assert_equal 'com', example_email.top_level_domain
    # end
  end
end
