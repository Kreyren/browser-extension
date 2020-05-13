FROM debian:latest

# FIXME: Requires novnc configuration

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true \
  && apt-get update \
  && apt-get install -y \
    novnc \
    firefox-esr \
    chromium \
    yarn