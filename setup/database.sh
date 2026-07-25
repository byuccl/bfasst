#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <family> <part>"
    exit 1
fi

family=$1
part=$2

# If not set, then set it
if [ -z "${FASM2BELS_PATH}" ]; then
    FASM2BELS_PATH=third_party/fasm2bels
fi

if [ -z "${FASM2BELS_PYTHON}" ]; then 
    FASM2BELS_PYTHON="${FASM2BELS_PATH}/env/conda/envs/f4pga_xc_fasm2bels/bin/python3"
fi

# Run the Python script with the provided family and part
"${FASM2BELS_PYTHON}" "${FASM2BELS_PATH}/fasm2bels/database/create_channels.py" --db-root "${FASM2BELS_PATH}/third_party/prjxray-db/${family}" --part "${part}" --connection-database-output "${FASM2BELS_PATH}/${part}_db"
