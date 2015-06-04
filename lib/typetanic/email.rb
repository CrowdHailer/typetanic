require_relative './util/forge'
require_relative './util/stash'
require_relative './exceptions'

module Typetanic
  class Email
    extend Forge
    extend Stash

    REGEX = /^(?<local_part>[^@]+)@(?<hostname>[^@]+)$/

    def initialize(value)
      @match = REGEX.match value.strip
      match or invalid value
    end

    attr_reader :match
    private :match

    def self.load(string)
      new string
    end

    def local_part
      match[:local_part]
    end

    def hostname
      match[:hostname]
    end

    def to_s
      @match.to_s
    end
    alias_method :to_str, :to_s
    alias_method :dump, :to_s

    def ==(other)
      other.is_a?(self.class) && to_s == other.to_s
    end
    # alias_method :eql?, :==

    private

    def invalid(bad_format)
      raise Invalid.new "'#{bad_format}' is not a valid email"
    end
  end
end
