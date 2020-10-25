# Changelog Reset

Resets a changelog back to the `## Unreleased` heading from a github release webhook event

## Configuration

### Environment Variables

This app uses the following environments variables:

| Name | Required | Description |
| ---| --- | ---|
| GITHUB_TOKEN| Yes| Token to access the github api, create the release and update the changelog on master |
| SECRET_TOKEN | Yes| If supplied it will do a HMAC check against the incomming request |

### Webhook

To configure the webhook you will want to do the following:

```none
URL: https://example.com/event_handler_comments
Events:
  Let me select:
    Releases (Only)
```

If you set a HMAC secret ensure that `SECRET_TOKEN` is set to the same secret value

## Docker images

Docker images are supplied under Xorima on docker hub, <https://hub.docker.com/r/xorima/changelog_reset/>
