module Typetanic
  module Forge
    def forge(raw)
      begin
        new raw
      rescue Typetanic::Invalid => err
        yield err
      end
    end
  end
end
