FROM debian:latest

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN apt install -y \
  firefox-esr \
  chromium

