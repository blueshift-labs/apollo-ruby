module Apollo
  class BaseModel < Hash
    def set(keys, value)
      return self if keys.nil?
      return self if value.nil?
      return self if keys.first.nil?

      if keys.count > 1
        self[keys.first] = BaseModel.new if self[keys.first].nil?
        self[keys.first].set(keys[1..-1], value)
      else
        self[keys.first] = if value.is_a?(Array)
                             ([self[keys.first]].flatten + value).uniq.compact
                           else
                             value
                           end
      end

      self
    end

    def inspect
      puts JSON.pretty_generate(self)
      self
    end
  end
end
