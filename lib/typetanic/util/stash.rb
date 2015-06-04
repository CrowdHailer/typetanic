module Typetanic
  module Stash
    ItemError = Class.new StandardError

    def dump(item)
      raise ItemError.new item unless item.is_a?(self)
      item.dump
    end
  end
end
