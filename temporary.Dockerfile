FROM debian:latest

# FIXME: Requires novnc configuration

ENV WINDOW_MANAGER="openbox"

USER root

# Get novnc dependencies
RUN true "" \
	&& apt-get update \
	&& apt-get install -y \
		xvfb \
		openbox \
		novnc

# NOTICE(Krey): Required for testing of the extension on gitpod
RUN true "" \
	&& apt-get update \
	&& apt-get install -y \
		firefox-esr \
		chromium

# Get misc
RUN true "" \
	&& apt-get update \
	&& apt-get install -y \
		yarn \
		wget \
		npm \
		shellcheck \
		dlocate

COPY gitpod/start-vnc-session.sh /usr/bin/start-vnc-session
RUN true "D4qqXP1uRk" \
	&& chmod -x /usr/bin/start-vnc-session \
	&& chmod +x /usr/bin/start-vnc-session \
	&& /usr/bin/start-vnc-session