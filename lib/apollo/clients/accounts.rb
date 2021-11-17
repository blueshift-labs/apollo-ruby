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

      def run_sanitizer(type:, document:, sanitizer: nil)
        handle_request("sanitize/accounts/#{@account}/types/#{type}", :get, body: {
          document: document,
          sanitizer: sanitizer
        }.delete_if { |_, v| v.nil? })
      end
    end
  end
end