all:
	@ exit 2

test-gitpod:
	@ git add -u
	@ git commit -m "$$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)"
	@ git push
	@ gp preview yolo
	@ gp preview https://gitpod.io/#https://github.com/Kreyren/gitpod-browser-extension/tree/test-implementation