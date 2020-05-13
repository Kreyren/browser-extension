FROM debian:latest

# FIXME: Requires novnc configuration

ENV WINDOW_MANAGER="openbox"

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
		wget \
		npm \
		shellcheck \
		dlocate

COPY gitpod/start-vnc-session.sh /usr/bin/start-vnc/session
RUN true "" \
	&& chmod +x /usr/bin/start-vnc-session \
	&& /usr/bin/start-vnc-session