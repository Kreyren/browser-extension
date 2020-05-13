FROM gitpod/workspace-full:latest

# BLOCKED: Ubuntu sucks and chromium on it doesn't work

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true \
  && apt-get update \
  && apt-get install -y \
    firefox-esr \
    chromium