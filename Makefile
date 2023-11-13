.SILENT: default
default: clean build


###########################################################################
DIST       := ./dist/

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

