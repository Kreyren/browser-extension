#!/bin/sh
# Created by Christian Weichel <csweichel@typefox.io> as unlicensed in 27/09/2018 (https://github.com/gitpod-io/workspace-images/commit/80774d83010c9f95dfef333ec04b9e10c51f27ed#diff-d1e16d016547874c1679decc84051173)
# Edited by Jan Keromnes <jankeromnes@typefox.io> as unlicensed in 25/01/2019(https://github.com/gitpod-io/workspace-images/commit/06b0aebb6598b71fee74871dcf33681c116465a7#diff-d1e16d016547874c1679decc84051173)
# Edited by Moritz Eysholdt <meysholdt@typefox.io> as unlicensed in 09/04/2019 (https://github.com/gitpod-io/workspace-images/commit/1da17a988e10c41dbefb2cbce2da7c12f9ee7bf5#diff-d1e16d016547874c1679decc84051173)
# Refactored by Jacob Hrbek <kreyren@rixotstudio.cz> under GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 13/05/2020 15:12

###! This is a script to configure novnc in gitpod to be used in theia's preview
###! Relevants:
###! - Reference to configuration on wikipedia https://en.wikipedia.org/wiki/Xvfb#Remote_control_over_SSH

set -e

myName="Script start-vnc-session"

# FIXME: Implement standard
die() {
	case "$1" in
		*) printf 'FATAL: %s\n' "$2" ;;
	esac

	exit "$1"
}

# NOTICE(Krey): We need DISPLAY variable to point to something
if [ -z "$DISPLAY" ]; then
	DISPLAY=":0"
elif [ -n "$DISPLAY" ]; then
	true
else
	die 255 "Processing DISPLAY variable in $myName"
fi

DISP="${DISPLAY##?}"

# FIXME-DOCS(Krey): According to wiki Xvfb is also used for remote control.  (why?)
if command -v Xvfb >/dev/null; then
	Xvfb -screen "$DISP" 1920x1080x16 -ac -pn -noreset &
elif ! command -v Xvfb >/dev/null; then
	# FIXME(Krey): Implement logic to get the package on system
	die 1 "Command 'Xvfb' is not executable on this system, unable to configure novnc for theia"
else
	die 255 "Processing Xvfb in $myName"
fi

# FIXME(Krey): Sanitize
$WINDOW_MANAGER &

VNC_PORT="$((5900 + $DISP))"
NOVNC_PORT="$((6080 + $DISP))"

# FIXME-DOCS(Krey)
if command -v x11vnc >/dev/null; then
	x11vnc -localhost -shared -display :$DISP -forever -rfbport ${VNC_PORT} -bg -o "/tmp/x11vnc-${DISP}.log"
elif ! command -v x11vnc >/dev/null; then
	# FIXME(Krey): Implement logic to get the package on system
	die 1 "Command 'x11vnc' is not executable on this system, unable to configure novnc for theia"
else
	die 255 "Processing x11vnc in $myName"
fi

# NOTICE(Krey): Start noVNC session
novncLaunch="/opt/novnc/utils/launch.sh"
if [ -f "$novncLaunch" ]; then
	if [ ! -x "$novncLaunch" ]; then
		chmod +x "$novncLaunch" || die 1 "Unable to set executable permission on file $novncLaunch"
	elif [ ! -x "$novncLaunch" ]; then
		true
	else
		die 255 "Setting executable permission on $novncLaunch in $myName"
	fi

	# FIXME-DOCS(Krey): Why are we using this script?
	# FIXME: Sanitize
	"$novncLaunch" --vnc "localhost:${VNC_PORT}" --listen "${NOVNC_PORT}" &
elif [ ! -f "$novncLaunch" ]; then
	die 1 "Unable to locate launch.sh from novnc in $myName"
else
	die 255 "Starting noVNC session in $myName"
fi
