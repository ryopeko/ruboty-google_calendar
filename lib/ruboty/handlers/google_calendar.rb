module Ruboty
  module Handlers
    class GoogleCalendar < Base
      on /schedule/, name: "schedule", description: "Fetch schedule from Google Calendar"

      def schedule(message)
        output = fetch.map {|s|
          "#{s[:summary]}\t#{s[:start]} - #{s[:end]}"
        }.join("\n")

        message.reply(output)
      end

      private

      def fetch
        @client ||= Ruboty::GoogleCalendar::Client.new
        @client.schedules.items.map do |s|
          {
            summary: s.summary,
            start: s.start.date_time,
            end: s.end.date_time
          }
        end
      end
    end
  end
end
