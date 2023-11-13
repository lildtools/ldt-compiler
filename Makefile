.SILENT: default
default: clean build

.SILENT: build
.SILENT: clean
.PHONY:  compile
.SILENT: install
.SILENT: test
.SILENT: watch

###########################################################################
DIST       := ./dist/
DIST_FILE  := ./dist/ldt-compiler.bash
SRC        := ./src/
SRC_APP    := ./src/main/bash/app/
SRC_TASKS  := ./src/main/bash/tasks/

install:
	((echo "[LDT] install...") && \
	 (apt-get update) && \
	 (apt-get install -y inotify-tools) && \
	 (echo "[LDT] install."))

clean:
	((echo "[LDT] clean...") && \
	 (if [ -d ${DIST} ]; then rm -rf ${DIST}; fi) && \
	 (echo "[LDT] clean."))

build:
	((echo "[LDT] build...") && \
	 (if [ ! -d ${DIST} ]; then mkdir ${DIST}; fi) && \
	 (echo "[LDT] compile...") && \
	 (if [ -d ${DIST} ]; then make --silent compile; fi) && \
	 (echo "[LDT] compile.") && \
	 (echo "[LDT] build."))


watch:
	((echo "[LDT] FileWatcher start... '${PWD}/src/**/*'") && \
	 (make compile) && \
	 (while inotifywait -q -r -e modify,move,create,delete ${SRC} >/dev/null; do \
	    make compile; \
	  done;) && \
	 (echo "[LDT] FileWatcher finished."))

compile:
	((cat ${SRC_APP}interpreter.sh >${DIST_FILE}) && \
	 (echo "" >>${DIST_FILE}) && \
	 (cat ${SRC_APP}main.sh >>${DIST_FILE}) && \
	 (find ${SRC_TASKS} -name '*.sh' -exec cat "{}" \; >>${DIST_FILE}) && \
	 (cat ${SRC_APP}loader.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}parser.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}validator.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}task-router.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}runner.sh >>${DIST_FILE}))
