module Ruboty
  module Handlers
    class GoogleCalendar < Base
      on /schedule/, name: "schedule", description: "Fetch schedule from Google Calendar"

      def schedule(message)
        message.reply(fetch)
      end

      private

      def fetch
        Ruboty::GoogleCalendar::Client.new.get
      end
    end
  end
end
