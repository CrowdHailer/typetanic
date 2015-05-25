module Typetanic
  # TODO test
  class Integer
    PredicatesUndefined = Class.new StandardError
    REGEX = /^\s*[+-]?\d+\s*$/
    def self.new(raw)
      return raw if raw.is_a? Integer
      match = raw[REGEX]
      raise Invalid unless match
      return match.to_i
    end

    def self.forge(raw)
      begin
        new raw
      rescue Typetanic::Invalid => err
        yield err
      end
    end
  end
end
