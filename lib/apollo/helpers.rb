module Apollo
  module Helpers
    def apollo
      AccountHelper.new(self.uuid)
    end

    class AccountHelper
      attr_reader :account
      def initialize(account)
        @account = account
      end

      def sanitizer
        Apollo::Sanitizer.new.account(self.account)
      end

      def index_sanitizer(index)
        Apollo::Sanitizer.new.index(index)
      end
    end
  end
end
