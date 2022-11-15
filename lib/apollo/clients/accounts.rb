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

      def sanitizer
        handle_request("sanitizers/account/#{@account}", :get)
      end

      def run_sanitizer(type:, document:, sanitizer: nil)
        handle_request("sanitize/accounts/#{@account}/types/#{type}", :get, body: {
          document: document,
          sanitizer: sanitizer
        }.delete_if { |_, v| v.nil? })
      end

      def update_sanitizer(sanitizer:, override:false)
        handle_request("sanitizers/account/#{@account}", :put, params: {override: override}, body: sanitizer)
      end

      def get_mapping(doc_type:)
        handle_request("mappings/accounts/#{@account}/#{doc_type}", :get)
      end
    end
  end
end
