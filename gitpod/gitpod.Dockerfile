FROM gitpod/workspace-full:latest

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true \
  && apt-get update \
  && apt-get install -y \
    firefox-esr \
    chromium