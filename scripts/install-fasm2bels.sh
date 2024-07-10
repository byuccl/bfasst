#!/bin/bash

set -e

source .venv/bin/activate

# If not set, then set it
if [ -z "${BFASST_PATH_FASM2BELS}" ] 
then
    BFASST_PATH_FASM2BELS=third_party/fasm2bels
fi

# Check if submodule path
if [ "${BFASST_PATH_FASM2BELS}" == "third_party/fasm2bels" ]
then
    USE_SUBMODULE=true
    git submodule init third_party/fasm2bels
    # git submodule sync third_party/fasm2bels
else
    USE_SUBMODULE=false
fi

if [ -z "${FASM2BELS_PYTHON_PATH}" ]
then 
    FASM2BELS_PYTHON_PATH="${BFASST_PATH_FASM2BELS}/env/conda/envs/f4pga_xc_fasm2bels/bin/python3"
fi

# Check if cache file matches current commit.  Will return "-" if submodule
# has not been initialized, so need to remove it.
FASM2BELS_COMMIT=$(git submodule status third_party/fasm2bels/ | awk '{print $1}')
if [ "${FASM2BELS_COMMIT::1}" = "-" ]
then
    FASM2BELS_COMMIT=${FASM2BELS_COMMIT:1}
fi

FASM2BELS_URL=$(git config --file .gitmodules submodule.third_party/fasm2bels.url)
echo "Need fasm2bels version: ${FASM2BELS_URL} ${FASM2BELS_COMMIT}"
    
if [ -f "${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt" ] && [ "${FASM2BELS_COMMIT}" == "$(cat ${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt)" ] ; then
    # Successful cache, do nothing
    echo "Found cached version of fasm2bels. No install required."
else
    echo "Installing new version of fasm2bels at ${BFASST_PATH_FASM2BELS}. This will be cached for future use."
    rm -rf "${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt"
    
    if [ "${USE_SUBMODULE}" = true ] ; then
        git submodule update --recursive third_party/fasm2bels
    else
        rm -rf "${BFASST_PATH_FASM2BELS}"
        git clone "${FASM2BELS_URL}" "${BFASST_PATH_FASM2BELS}"
        cd "${BFASST_PATH_FASM2BELS}" && git reset --hard "${FASM2BELS_COMMIT}" && cd -
    fi

    cd "${BFASST_PATH_FASM2BELS}"
    make env
    make build
    make test-py
    cd -

    # Generate the part db to cache
    "${FASM2BELS_PYTHON_PATH}" "${BFASST_PATH_FASM2BELS}/fasm2bels/database/create_channels.py" --db-root "${BFASST_PATH_FASM2BELS}/third_party/prjxray-db/artix7" --part "xc7a200tsbg484-1" --connection-database-output "${BFASST_PATH_FASM2BELS}/xc7a200tsbg484-1_db"

    echo "${FASM2BELS_COMMIT}" > "${BFASST_PATH_FASM2BELS}/fasm2bels_commit.txt"
fi
