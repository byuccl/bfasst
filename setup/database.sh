#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <family> <part>"
    exit 1
fi

family=$1
part=$2

# If not set, then set it
if [ -z "${BFASST_PATH_FASM2BELS}" ]; then
    BFASST_PATH_FASM2BELS=third_party/fasm2bels
fi

if [ -z "${FASM2BELS_PYTHON_PATH}" ]; then 
    FASM2BELS_PYTHON_PATH="${BFASST_PATH_FASM2BELS}/env/conda/envs/f4pga_xc_fasm2bels/bin/python3"
fi

# Run the Python script with the provided family and part
"${FASM2BELS_PYTHON_PATH}" "${BFASST_PATH_FASM2BELS}/fasm2bels/database/create_channels.py" --db-root "${BFASST_PATH_FASM2BELS}/third_party/prjxray-db/${family}" --part "${part}" --connection-database-output "${BFASST_PATH_FASM2BELS}/${part}_db"
