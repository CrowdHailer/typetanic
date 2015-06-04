require_relative './util/forge'
require_relative './util/stash'

module Typetanic
  class Email
    extend Forge
    extend Stash

    def initialize(value)
      self.value = value
    end

    def self.load(string)
      new string
    end

    def to_s
      value
    end
    alias_method :to_str, :to_s
    alias_method :dump, :to_s

    def value
      @value
    end

    def value=(new_value)
      @value = new_value.strip[/^[^@]+@[^@]+$/] || invalid(new_value)
    end

    def ==(other)
      other.is_a?(self.class) && value == other.value
    end
    # alias_method :eql?, :==

    private

    def invalid(bad_format)
      raise Invalid.new "'#{bad_format}' is not a valid email"
    end
  end
end
