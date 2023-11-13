## ldt-compiler

.SILENT: default
default: clean build

###########################################################################
.SILENT: build
.SILENT: clean
.PHONY:  compile
.SILENT: e2e
.SILENT: install
.SILENT: test
.SILENT: usage
.SILENT: watch

###########################################################################
APP_NAME     := ldt-compiler
APP_VERSION  := $(shell cat ./VERSION)
APP_ALIAS    := ${PWD}/dist/${APP_NAME}-${APP_VERSION}.sh

DIST         := ./dist/
DIST_FILE    := ./dist/${APP_NAME}-${APP_VERSION}.sh

SRC          := ./src/
SRC_APP      := ./src/main/sh/app/
SRC_TASKS    := ./src/main/sh/tasks/

RESOURCES    := ./src/main/resources/

###########################################################################
build:
	((echo "[LDTC] build...") && \
	 (if [ ! -d ${DIST} ]; then mkdir ${DIST}; fi) && \
	 (echo "[LDTC] compile...") && \
	 (if [ -d ${DIST} ]; then make --silent compile; fi) && \
	 (echo "[LDTC] compile.") && \
	 (echo "[LDTC] build."))

clean:
	((echo "[LDTC] clean...") && \
	 (if [ -d ${DIST} ]; then rm -rf ${DIST}; fi) && \
	 (echo "[LDTC] clean."))

install:
	((echo "[LDTC] install...") && \
	 (apt-get update) && \
	 (apt-get install -y inotify-tools) && \
	 (echo "[LDTC] install."))

test:
	((echo "[LDTC] Tester run all...") && \
	 (echo "[LDTC] Tester finished."))

watch:
	((echo "[LDTC] FileWatcher start... '${PWD}/src/**/*'") && \
	 (make compile) && \
	 (while inotifywait -q -r -e modify,move,create,delete ${SRC} >/dev/null; do \
	    make compile; \
	  done;) && \
	 (echo "[LDTC] FileWatcher finished."))

usage:
	((echo "doPrintUsage() {">${SRC_TASKS}doPrintUsage.sh) && \
	 (echo "echo \"=============================================">>${SRC_TASKS}doPrintUsage.sh) && \
	 (cat ${RESOURCES}USAGE.txt >>${SRC_TASKS}doPrintUsage.sh) && \
	 (echo "\"">>${SRC_TASKS}doPrintUsage.sh) && \
	 (echo "}">>${SRC_TASKS}doPrintUsage.sh))

compile:
	((if [ -f ${RESOURCES}USAGE.txt ]; then make usage; fi) && \
	 (cat ${SRC_APP}main.sh >${DIST_FILE}) && \
	 (cat ${SRC_APP}parser.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}loader.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}validator.sh >>${DIST_FILE}) && \
	 (cat ${SRC_APP}router.sh >>${DIST_FILE}) && \
	 (find ${SRC_TASKS} -name '*.sh' -exec cat "{}" \; >>${DIST_FILE}) && \
	 (cat ${SRC_APP}runner.sh >>${DIST_FILE}) && \
	 (chmod 755 ${DIST_FILE}))
