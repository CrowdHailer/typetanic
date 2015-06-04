module Typetanic
  module Forge
    def forge(raw)
      new raw
    rescue Typetanic::Invalid => error
      yield error
    end
  end
end
