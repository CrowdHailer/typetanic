require_relative './../test_config'

module Typetanic
  class EmailTest < MiniTest::Test
    def example_string
      @example_string ||= 'test@example.com'
    end

    def example_email
      @example_email ||= Email.new(example_string)
    end

    def test_is_equal_for_same_email
      assert_equal example_email, Email.new('test@example.com')
    end

    def test_clears_white_space
      assert_equal example_email, Email.new('  test@example.com')
    end

    def test_shows_as_a_string
      assert_equal example_string, example_email.to_s
    end

    def test_adds_to_strings
      assert_equal example_string, example_email.to_str
    end

    def test_is_not_equal_to_string
      refute_equal example_email, example_string
    end

    def test_raises_error_for_email_with_no_at
      assert_raises Email::Invalid do
        Email.new('bad')
      end
    end

    def test_raises_error_for_email_with_two_ats
      assert_raises Email::Invalid do
        Email.new('a@b@c.com')
      end
    end

    def test_raises_error_when_dumping_not_an_email
      assert_raises Stash::ItemError do
        Email.dump('string')
      end
    end

    # def test_separates_domains
    #   assert_equal ['com', 'example'], example_email.domains
    # end
    #
    # def test_fetch_top_level_domain
    #   assert_equal 'com', example_email.top_level_domain
    # end
    #
    # def test_separates_local_part
    #   assert_equal 'example', example_email.local
    # end
    #
    # def test_separates_hostname
    #   assert_equal 'example.com', example_email.hostname
    # end
  end
end
