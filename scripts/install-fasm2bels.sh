#!/bin/bash

set -e

source .venv/bin/activate

# If not set, then set it
if [ -z "${BFASST_PATH_FASM2BELS}" ] 
then
    BFASST_PATH_FASM2BELS=third_party/fasm2bels
fi

# Check if submodule path
if [ ${BFASST_PATH_FASM2BELS} == "third_party/fasm2bels" ]
then
    USE_SUBMODULE=true
    git submodule init third_party/fasm2bels
    # git submodule sync third_party/fasm2bels
else
    USE_SUBMODULE=false
fi

# Check if cache file matches current commit.  Will return "-" if submodule
# has not been initialized, so need to remove it.
FASM2BELS_COMMIT=$(git submodule status third_party/fasm2bels/ | awk '{print $1}')
if [ ${FASM2BELS_COMMIT::1} = "-" ]
then
    FASM2BELS_COMMIT=${FASM2BELS_COMMIT:1}
fi

FASM2BELS_URL=$(git config --file .gitmodules submodule.third_party/fasm2bels.url)
echo "Need fasm2bels version: ${FASM2BELS_URL} ${FASM2BELS_COMMIT}"
    
if [ -f ${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt ] && [ $FASM2BELS_COMMIT == $(cat ${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt) ] ; then
    # Successful cache, do nothing
    touch ${BFASST_PATH_FASM2BELS}/"db_marker"
    echo "Found cached version of fasm2bels. No install required."
else
    echo Installing new version of fasm2bels at ${BFASST_PATH_FASM2BELS}. This will be cached for future use.
    rm -rf ${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt
    
    if [ ${USE_SUBMODULE} = true ] ; then
        git submodule update --recursive third_party/fasm2bels
    else
        rm -rf ${BFASST_PATH_FASM2BELS}
	    git clone ${FASM2BELS_URL} ${BFASST_PATH_FASM2BELS}
	    cd ${BFASST_PATH_FASM2BELS} && git reset --hard ${FASM2BELS_COMMIT} && cd -
    touch ${BFASST_PATH_FASM2BELS}/"db_marker"
    fi

	cd ${BFASST_PATH_FASM2BELS}
    make env
	make build
	make test-py
    cd -

    # Run a design to generate the part database
    python scripts/run.py VivadoBitToNetlist designs/basic/and3 --no_tool_checks

    echo $FASM2BELS_COMMIT > ${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt
fi

