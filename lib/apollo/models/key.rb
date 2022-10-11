module Apollo
  class Key
    attr_accessor :path

    def to_leaf
      @is_leaf = true
      self
    end

    def to_pattern
      @is_pattern = true
      self
    end

    def append_path(*nodes)
      self.path = [] if self.path.nil?
      self.path += nodes
      self
    end

    def to_s
      raise 'empty key' if self.path.nil? || self.path.empty?

      s = self.path.join('!;')
      s = "!##{s}" if @is_pattern
      s = "!-#{s}" if @is_leaf
      s
    end

    def as_json(options = {})
      self.to_s
    end
  end
end
