FROM debian:latest

# FIXME: Requires novnc configuration

ENV WINDOW_MANAGER="openbox"

USER root

# Get novnc dependencies
RUN true "" \
	&& apt-get update \
	&& apt-get install -y \
		debconf \
		xvfb \
		x11vnc \
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

# DNM terrible
# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the X
# server is running on screen 0, and if not starts Xvfb, x11vnc and novnc.
#RUN echo "[ ! -e /tmp/.X0-lock ] && (/usr/bin/start-vnc-session.sh &> /tmp/display-\${DISPLAY}.log)" >> ~/.bashrc

COPY gitpod/start-vnc-session.sh /usr/bin/start-vnc-session
RUN true "replace" \
	&& chmod -x /usr/bin/start-vnc-session \
	&& chmod +x /usr/bin/start-vnc-session \
	&& /usr/bin/start-vnc-session

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	>> /etc/bash.bashrc; fi

# DNM: Death is only the beginning!
RUN exit 88