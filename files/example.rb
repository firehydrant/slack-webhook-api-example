#! /usr/bin/env ruby
require 'bundler'
require 'json'
require 'rest_client'
require 'active_support/core_ext'
require 'active_support/json'

FIREHYDRANT_INCIDENTS_URL = "#{ENV['FIREHYDRANT_API_URL']}/v1/incidents?active=true"
FIREHYDRANT_BOT_TOKEN = ENV['FIREHYDRANT_BOT_TOKEN']
FIREHYDRANT_HEADERS = {
  "Authorization" => "bearer #{FIREHYDRANT_BOT_TOKEN}"
}
SLACK_WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']
SLACK_HEADERS = {
  "Content-Type" => "application/json"
}

resp = RestClient::Request.execute(url: FIREHYDRANT_INCIDENTS_URL, method: :get, headers: FIREHYDRANT_HEADERS, :verify_ssl => false)
incidents = JSON.parse(resp)["data"]

slack_payload = {
  "text": ":fire: #{incidents.count} active #{"incident".pluralize(incidents.count)} in FireHydrant",
  "blocks": [
      {
          "type": "section",
          "text": {
              "type": "mrkdwn",
              "text": ":fire: *#{incidents.count} active #{"incident".pluralize(incidents.count)} in FireHydrant*"
          }
      },
  ]
}

slack_payload[:blocks] += incidents.map do |i|
  {
    "type": "section",
    "text": {
      "type": "mrkdwn",
      "text": "#{i["name"]}\n#{i["summary"]}"
    },
    "accessory": {
      "type": "button",
      "text": {
        "type": "plain_text",
        "text": "Command Center"
      },
      "url": i["incident_url"]
    }
  }
end

RestClient.post(SLACK_WEBHOOK_URL, slack_payload.to_json, SLACK_HEADERS)
