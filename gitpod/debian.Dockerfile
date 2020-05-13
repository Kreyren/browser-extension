FROM debian:latest

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true \
  && apt update \
  && apt install -y \
    firefox-esr \
    chromium

