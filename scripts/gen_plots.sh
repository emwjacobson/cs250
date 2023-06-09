#!/bin/bash

ROOT_DIR=/cb-multios
PERSISTENT_ROOT=/persistent

CHALLENGES_CLEAN=/binaries

for CHALLENGE_DIR in ${PERSISTENT_ROOT}/*; do
  CHALLENGE_NAME=`basename ${CHALLENGE_DIR}`
  PERSISTENT_LOCAL=${PERSISTENT_ROOT}/${CHALLENGE_NAME}
  OUTPUT_DIR=${PERSISTENT_LOCAL}/out

  mkdir -p ${PERSISTENT_LOCAL}/plots

  for INSTANCE in ${OUTPUT_DIR}/${CHALLENGE_NAME}*; do # Limit it to CHALLENGE_NAME-[M/S]
    INSTANCE_NAME=`basename ${INSTANCE}`
    afl-plot ${INSTANCE} ${PERSISTENT_LOCAL}/plots/${INSTANCE_NAME}
  done

done
