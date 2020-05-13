all:
	@ exit 2

gitpod-common:
	@ cat gitpod/debian.Dockerfile | sed -E "s#(RUN\s{1}true\s{1}\")(replace)(\"\s{1})#\1$$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)\3#gm" > temporary.Dockerfile
	@ git add -u 
	@ git commit -m "$$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)" || true
	@ git push || true
	@ gp preview yolo || true

test-gitpod: gitpod-common
	@ gp preview https://gitpod.io/#https://github.com/Kreyren/gitpod-browser-extension/tree/test-implementation

test-gitpod-staging: gitpod-common
	@ gp preview https://gitpod-staging.com/#https://github.com/Kreyren/gitpod-browser-extension/tree/test-implementation