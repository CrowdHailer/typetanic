require_relative './util/forge'
require_relative './util/stash'
require_relative './exceptions'

module Typetanic
  class Email
    extend Forge
    extend Stash

    REGEX = /^(?<local_part>[^@]+)@(?<hostname>[^@]+)$/

    def initialize(raw)
      @match = REGEX.match raw.strip
      unless match
        raise Invalid.new "'#{raw}' is not a valid email"
      end
    end

    attr_reader :match
    private :match

    def local_part
      match[:local_part]
    end

    def hostname
      match[:hostname]
    end

    def domains
      array = hostname.split '.'
      array.reverse
    end

    def top_level_domain
      domains.first
    end

    def to_s
      @match.to_s
    end
    alias_method :to_str, :to_s

    def ==(other)
      to_s == other.to_s
    end

    def self.load(string)
      new string
    end
    alias_method :dump, :to_s
  end
end
