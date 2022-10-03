module Apollo
  class Sanitizer < BaseModel
    def account(account)
      @account = account
      self
    end

    def index(index)
      @index = index
      self
    end

    def load(bm)
      self.clear
      bm.each do |k, v|
        self[k] = v
      end
      self
    end

    def underscore_key(type:nil, default:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_underscore_keys, :default], default)
        self.set([:default_underscore_keys, :keys, key], value)
      else
        self.set([:underscore_keys, type.to_sym, :default], default)
        self.set([:underscore_keys, type.to_sym, :keys, key], value)
      end

      self
    end

    def downcase_key(type:nil, default:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_downcase_keys, :default], default)
        self.set([:default_downcase_keys, :keys, key], value)
      else
        self.set([:downcase_keys, type.to_sym, :default], default)
        self.set([:downcase_keys, type.to_sym, :keys, key], value)
      end

      self
    end

    def max_key_len(type:nil, default:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_max_key_lens, :default], default)
        self.set([:default_max_key_lens, :keys, key], value)
      else
        self.set([:max_key_lens, type.to_sym, :default], default)
        self.set([:max_key_lens, type.to_sym, :keys, key], value)
      end

      self
    end

    def downcase_value(type:nil, default:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_downcase_values, :default], default)
        self.set([:default_downcase_values, :keys, key], value)
      else
        self.set([:downcase_values, type.to_sym, :default], default)
        self.set([:downcase_values, type.to_sym, :keys, key], value)
      end

      self
    end

    def max_value_len(type:nil, default:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_max_value_lens, :default], default)
        self.set([:default_max_value_lens, :keys, key], value)
      else
        self.set([:max_value_lens, type.to_sym, :default], default)
        self.set([:max_value_lens, type.to_sym, :keys, key], value)
      end

      self
    end

    def rename(type:nil, key:nil, value:nil)
      if type.nil?
        self.set([:default_renames, key], value)
      else
        self.set([:renames, type.to_sym, key], value)
      end

      self
    end

    def blacklist(type:nil, key:nil)
      if type.nil?
        self.set([:default_blacklist], [key].flatten)
      else
        self.set([:blacklists, type.to_sym], [key].flatten)
      end

      self
    end

    def type_mapping(key:nil, value:nil)
      self.set([:type_mappings, key], value)

      self
    end

    def fetch
      if !@index.nil?
        Apollo.indices.for_index(@index).sanitizer
      elsif !@account.nil?
        Apollo.accounts.for_account(@account).sanitizer
      else
        raise 'missing account or index'
      end
    end

    def update
      if !@index.nil?
        Apollo.indices.for_index(@index).update_sanitizer(sanitizer: self, override: false)
      elsif !@account.nil?
        Apollo.indices.for_account(@index).update_sanitizer(sanitizer: self, override: false)
      else
        raise 'missing account or index'
      end
    end

    def override
      if !@index.nil?
        Apollo.indices.for_index(@index).update_sanitizer(sanitizer: self, override: true)
      elsif !@account.nil?
        Apollo.indices.for_account(@index).update_sanitizer(sanitizer: self, override: true)
      else
        raise 'missing account or index'
      end
    end

    def run_sanitizer(type:, document:)
      if !@index.nil?
        Apollo.indices.for_index(@index).run_sanitizer(
          type: type,
          document: document,
          sanitizer: self
        )
      elsif !@account.nil?
        Apollo.accounts.for_account(@account).run_sanitizer(
          type: type,
          document: document,
          sanitizer: self
        )
      else
        raise 'missing account or index'
      end
    end
  end
end
