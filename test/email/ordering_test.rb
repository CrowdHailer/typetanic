require_relative './../test_config'

module Typetanic
  class EmailTest < MiniTest::Test
    def test_orders_on_top_level_domain
      email1 = Email.new 'a@c'
      email2 = Email.new 'a@x'
      comparison = email1 <=> email2
      assert_equal -1, comparison
    end

    def test_orders_on_subsequent_domains
      email1 = Email.new 'a@a.c'
      email2 = Email.new 'a@b.c'
      comparison = email1 <=> email2
      assert_equal -1, comparison
    end

    def test_orders_no_domain_ahead_of_subdomain
      email1 = Email.new 'a@c'
      email2 = Email.new 'a@b.c'
      comparison = email1 <=> email2
      assert_equal -1, comparison
    end

    def test_orders_by_local_part_for_same_domain
      email1 = Email.new 'a@c'
      email2 = Email.new 'b@c'
      comparison = email1 <=> email2
      assert_equal -1, comparison
    end
  end
end
