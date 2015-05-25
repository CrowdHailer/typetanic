module Typetanic
  # TODO test
  class Boolean
    extend Forge
    PredicatesUndefined = Class.new StandardError

    def self.affirmative
      raise PredicatesUndefined, 'No affirmative inputs'
    end

    def self.negative
      raise PredicatesUndefined, 'No negative inputs'
    end

    def self.affirmative?(raw)
      affirmative.include? raw
    end

    def self.negative?(raw)
      negative.include? raw
    end

    def self.new(raw)
      return true if affirmative? raw
      return false if negative? raw
      raise Invalid, "'#{raw}' is neither affirmative or negative"
    end

  end

  def self.Boolean(affirmative:, negative:)
    Class.new Boolean do
      define_singleton_method :affirmative do
        affirmative
      end

      define_singleton_method :negative do
        negative
      end
    end
  end

end
