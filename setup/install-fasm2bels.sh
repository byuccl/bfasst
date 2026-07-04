#!/bin/bash

set -e

source .venv/bin/activate

# If not set, then set it
if [ -z "${FASM2BELS_PATH}" ] 
then
    FASM2BELS_PATH=third_party/fasm2bels
fi

# Check if submodule path
if [ "${FASM2BELS_PATH}" == "third_party/fasm2bels" ]
then
    USE_SUBMODULE=true
    git submodule init third_party/fasm2bels
    # git submodule sync third_party/fasm2bels
else
    USE_SUBMODULE=false
fi

if [ -z "${FASM2BELS_PYTHON}" ]
then 
    FASM2BELS_PYTHON="${FASM2BELS_PATH}/env/conda/envs/f4pga_xc_fasm2bels/bin/python3"
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
    
if [ -f "${FASM2BELS_PATH}/fasm2bels_commit.txt" ] && [ "${FASM2BELS_COMMIT}" == "$(cat ${FASM2BELS_PATH}/fasm2bels_commit.txt)" ] ; then
    # Successful cache, do nothing
    echo "Found cached version of fasm2bels. No install required."
    if [ ! -f ${FASM2BELS_PATH}/${part}_db ] ; then
        echo "Part database not found, generating database for artix7 xc7a200tsbg484-1"
        ./scripts/database.sh artix7 xc7a200tsbg484-1
    fi
    else 
        echo "Part database found for ${part}, no need to regenerate."
    fi
else
    echo "Installing new version of fasm2bels at ${FASM2BELS_PATH}. This will be cached for future use."
    rm -rf "${FASM2BELS_PATH}/fasm2bels_commit.txt"
    
    if [ "${USE_SUBMODULE}" = true ] ; then
        git submodule update --recursive third_party/fasm2bels
    else
        rm -rf "${FASM2BELS_PATH}"
        git clone "${FASM2BELS_URL}" "${FASM2BELS_PATH}"
        cd "${FASM2BELS_PATH}" && git reset --hard "${FASM2BELS_COMMIT}" && cd -
    fi

    cd "${FASM2BELS_PATH}"
    make env
    make build
    make test-py
    cd -

    # Generate the part database to cache for future use
    # If you need the database for another part, run the script below with the family and part as arguments
    ./scripts/database.sh artix7 xc7a200tsbg484-1

    echo "${FASM2BELS_COMMIT}" > "${FASM2BELS_PATH}/fasm2bels_commit.txt"
fi
