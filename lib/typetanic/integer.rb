module Typetanic
  # TODO test
  class Integer
    extend Forge
    PredicatesUndefined = Class.new StandardError
    REGEX = /^\s*[+-]?\d+\s*$/
    def self.new(raw)
      return raw if raw.is_a? Integer
      match = raw[REGEX]
      raise Invalid unless match
      return match.to_i
    end

  end
end
