#!/bin/bash

ROOT_DIR=/cb-multios
PERSISTENT_ROOT=/persistent

CHALLENGES_CLEAN=${ROOT_DIR}/binaries

for CHALLENGE_DIR in ${CHALLENGES_CLEAN}/*; do
  CHALLENGE_NAME=`basename ${CHALLENGE_DIR}`
  PERSISTENT_LOCAL=${PERSISTENT_ROOT}/${CHALLENGE_NAME}; mkdir -p ${PERSISTENT_LOCAL}

  printf "======== ${CHALLENGE_NAME} ========\n"

  afl-whatsup -s ${PERSISTENT_LOCAL}/out 2>/dev/null

  printf "\n\n"
done

