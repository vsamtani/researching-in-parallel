#!/bin/bash
# verify_agent_outputs.sh
# Check if expected research outputs exist before synthesis step.
# Usage: ./verify_agent_outputs.sh [TOPIC_SLUG] [DATE] [WORKSPACE_PATH]

TOPIC_SLUG=$1
DATE=$2
WORKSPACE_PATH=${3:-.}

if [ -z "$TOPIC_SLUG" ] || [ -z "$DATE" ]; then
  echo "Usage: $0 [TOPIC_SLUG] [DATE] [WORKSPACE_PATH]"
  exit 1
fi

EXPECTED_FILES=(
  "research-breadth-${TOPIC_SLUG}-${DATE}.md"
  "research-critical-${TOPIC_SLUG}-${DATE}.md"
  "research-evidence-${TOPIC_SLUG}-${DATE}.md"
)

MISSING=0

for file in "${EXPECTED_FILES[@]}"; do
  if [ ! -f "${WORKSPACE_PATH}/${file}" ]; then
    echo "Missing: ${file}"
    MISSING=1
  else
    echo "Found: ${file}"
  fi
done

if [ $MISSING -eq 1 ]; then
  echo "Error: One or more required research outputs are missing."
  exit 1
fi

echo "All required outputs verified."
exit 0
