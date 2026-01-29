#!/bin/sh

# Configuration

SCRIPT=extract.sh
WORKSPACE=${TMPDIR:-/tmp}/${SCRIPT}.$(id -u)
NSOURCE=5
FAILURES=0

# Utilities

error() {
    echo "ERROR: $@" 1>&2
}

cleanup() {
    rm -fr ${WORKSPACE}
    exit $1
}

test_script() {
    rm -fr ${WORKSPACE}/data
    if ! (cd ${WORKSPACE}; ./${SCRIPT} $1 > /dev/null; test -d data); then
	error "Executing ${SCRIPT} $1 failed!"
	FAILURES=$(($FAILURES + 1))
    fi
}

# Main execution

## 1. Check script
if [ ! -r ${SCRIPT} ]; then
    error "${SCRIPT} is not readable!"
    exit 1
fi

if [ ! -x ${SCRIPT} ]; then
    error "${SCRIPT} is not executable!"
    exit 2
fi

## 2. Create workspace

mkdir ${WORKSPACE}
trap "cleanup 1" INT TERM HUP QUIT STOP
trap "cleanup 0" EXIT

## 3. Copy script to workspace
cp ${SCRIPT} ${WORKSPACE}

## 4. Create archives
mkdir -p ${WORKSPACE}/data

for i in $(seq 1 ${NSOURCE}); do
    touch ${WORKSPACE}/data/file.$i
done
(cd ${WORKSPACE} ; tar czf ${WORKSPACE}/archive.tgz data ; ln archive.tgz archive.tar.gz)
(cd ${WORKSPACE} ; tar cjf ${WORKSPACE}/archive.tbz data ; ln archive.tbz archive.tar.bz2)
(cd ${WORKSPACE} ; tar cJf ${WORKSPACE}/archive.txz data ; ln archive.txz archive.tar.xz)
(cd ${WORKSPACE} ; zip -qr ${WORKSPACE}/archive.zip data ; ln archive.zip archive.jar)

## 5. Test script
if ! ${WORKSPACE}/${SCRIPT} | grep -i 'usage' > /dev/null; then
    error "${SCRIPT} doesn't handle empty arguments!"
    FAILURES=$(($FAILURES + 1))
fi

for ext in tgz tar.gz tbz tar.bz2 txz tar.xz zip jar; do
    test_script archive.${ext}
done
    
test_script archive.tgz archive.bz2 archive.txz archive.zip

if ! ${WORKSPACE}/${SCRIPT} taco.cat | grep -i 'unknown' > /dev/null; then
    error "${SCRIPT} doesn't handle unknown archive formats!"
    FAILURES=$(($FAILURES + 1))
fi

## 6. Report test results

if [ "${FAILURES}" -eq 0 ]; then
    echo "${SCRIPT} test successful!"
else
    echo "${SCRIPT} had ${FAILURES} failures!"
fi
exit ${FAILURES}
