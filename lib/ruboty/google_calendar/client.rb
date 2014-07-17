require 'google/api_client'
require 'google/api_client/client_secrets'
require 'active_support/core_ext'

module Ruboty
  module GoogleCalendar
    class Client
      GOOGLE_CALENDAR_SCOPE = 'https://www.googleapis.com/auth/calendar'
      GOOGLE_AUTH_URI  = 'https://accounts.google.com/o/oauth2/auth'
      GOOGLE_TOKEN_URI = 'https://accounts.google.com/o/oauth2/token'

      def initialize
        google_api_client = Google::APIClient.new(
          application_name: 'ruboty-google_calendar',
          application_version: Ruboty::GoogleCalendar::VERSION
        )

        @calendar = google_api_client.discovered_api('calendar', 'v3')

        client_secrets = Google::APIClient::ClientSecrets.new(
          flow: :installed,
          installed: {
            client_id: ENV['GOOGLE_API_CLIENT_ID'],
            auth_uri: GOOGLE_AUTH_URI,
            client_secret: ENV['GOOGLE_CLIENT_SECRET'],
            token_uri: GOOGLE_TOKEN_URI,
            redirect_uris: [ENV['GOOGLE_REDIRECT_URI']],
            refresh_token: ENV['GOOGLE_REFRESH_TOKEN']
          }
        )

        google_api_client.authorization = client_secrets.to_authorization
        google_api_client.authorization.scope = GOOGLE_CALENDAR_SCOPE

        @calendar_id = ENV['GOOGLE_CALENDAR_ID'] || 'primary'

        @client = google_api_client
      end

      def schedules
        time_offset = ENV['GOOGLE_CALENDAR_SCHEDULE_TIME_OFFSET_DAYS'].try(:to_i) || 7

        @client.authorization.fetch_access_token!
        @client.execute(
          api_method: @calendar.events.list,
          parameters: {
            calendarId: @calendar_id,
            singleEvents: true,
            timeMin: Time.now.iso8601,
            timeMax: time_offset.days.since.iso8601
          }
        ).data
      end
    end
  end
end
