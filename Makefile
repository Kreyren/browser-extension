all:
	@ exit 2

test-gitpod:
	@ cat gitpod/debian.Dockerfile | sed -E "s#(RUN\s{1}true\s{1}\")(replace)(\"\s{1})#\1$$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)\3#gm" > temporary.Dockerfile
	@ git add -u 
	@ git commit -m "$$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)" || true
	@ git push || true
	@ gp preview yolo || true
	@ gp preview https://gitpod.io/#https://github.com/Kreyren/gitpod-browser-extension/tree/test-implementation