module Apollo
  def self.accounts
    Accounts.new
  end

  class Accounts < BaseClient
    def for_account(account)
      Account.new(account)
    end

    class Account < BaseClient
      def initialize(account)
        @account = account
      end

      def sanitizer(include_defaults: false)
        if include_defaults
          handle_request("sanitizers/account/#{@account}", :get, params: { include_defaults: true })
        else
          handle_request("sanitizers/account/#{@account}", :get)
        end
      end

      def run_sanitizer(type:, document:, sanitizer: nil)
        handle_request("sanitize/accounts/#{@account}/types/#{type}", :get, body: {
          document: document,
          sanitizer: sanitizer
        }.delete_if { |_, v| v.nil? })
      end

      def update_sanitizer(sanitizer:, override: false)
        handle_request("sanitizers/account/#{@account}", :put, params: { override: override }, body: sanitizer)
      end

      def get_mapping(doc_type:)
        handle_request("mappings/accounts/#{@account}/#{doc_type}", :get)
      end

      def get_dictionary(doc_type:)
        handle_request("dictionary/#{@account}/#{doc_type}", :get)
      end

      def update_description(doc_type:, field:, description:)
        handle_request("dictionary/#{@account}/#{doc_type}/description", :put, body: { "field": field, "description": description })
      end

      def get_autocomplete(doc_type:, path:, size:)
        handle_request("schema/values/#{@account}/types/#{doc_type}", :get, params: { path: path, size: size })
      end
    end
  end
end
``