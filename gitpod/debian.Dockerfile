FROM debian:latest

# FIXME: Requires novnc configuration

USER root

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true "" \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    openbox \
    novnc \
    firefox-esr \
    chromium \
    yarn \
  && wget https://raw.githubusercontent.com/gitpod-io/workspace-images/master/full-vnc/start-vnc-session.sh -O /usr/bin/start-vnc-session \
  && chmod +x /usr/bin/start-vnc-session \
  && /usr/bin/start-vnc-session