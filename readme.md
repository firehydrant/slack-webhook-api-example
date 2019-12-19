# FireHydrant API => Slack API example

This is an example of how to display FireHydrant API data in a Slack channel or DM on a regular basis.

![Example Usage](https://raw.githubusercontent.com/firehydrant/slack-webhook-api-example/master/screenshot.png)

## Usage

1. Create a [Slack incoming webhook](https://api.slack.com/messaging/webhooks)
2. Add a Bot token and the Slack webhook to manifests/secret.yaml
3. Update files/example.rb to include the information you'd like to display. This uses Slack's [Block Kit](https://api.slack.com/block-kit) to render the messages
4. Run `make` to render the configmap manifest to include your new code
5. Run `make apply` or `kubectl apply -f manifests/ -n YOUR_NAMESPACE
6. Watch Slack
