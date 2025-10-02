#!/bin/sh -eu

#
#  workspace-prepare.sh
#  LoopWorkspaceApex
#
#  Created by Darin Krauss on 2/3/20.
#  Copyright © 2020 Tidepool Project. All rights reserved.
#

SCRIPT="$(basename "${0}")"
SCRIPT_DIRECTORY="$(dirname "${0}")"
WORKSPACE_DIRECTORY="${SCRIPT_DIRECTORY}/.."

error() {
  echo "ERROR: ${*}" >&2
  echo "Usage: ${SCRIPT} <build-id>" >&2
  exit 1
}

if [ ${#} -ne 0 ]; then
  error "Unexpected arguments: ${*}"
fi

rm -rf "${WORKSPACE_DIRECTORY}/Loop/VersionOverride.xcconfig"
rm -rf "${WORKSPACE_DIRECTORY}/Loop/LoopOverride.xcconfig"
rm -rf "${WORKSPACE_DIRECTORY}/Loop/Loop/DerivedAssetsOverride.xcassets"
rm -rf "${WORKSPACE_DIRECTORY}/Loop/WatchApp/DerivedAssetsOverride.xcassets"
rm -rf "${WORKSPACE_DIRECTORY}/Loop/Loop Widget Extension/DerivedAssetsOverride.xcassets"

ln -s "../Tidepool/Loop/VersionOverride.xcconfig" "${WORKSPACE_DIRECTORY}/Loop/VersionOverride.xcconfig"
ln -s "../Tidepool/Loop/LoopOverride.xcconfig" "${WORKSPACE_DIRECTORY}/Loop/LoopOverride.xcconfig"
ln -s "../../Tidepool/Loop/Loop/DerivedAssetsOverride.xcassets" "${WORKSPACE_DIRECTORY}/Loop/Loop/DerivedAssetsOverride.xcassets"
ln -s "../../Tidepool/Loop/WatchApp/DerivedAssetsOverride.xcassets" "${WORKSPACE_DIRECTORY}/Loop/WatchApp/DerivedAssetsOverride.xcassets"
ln -s "../../Tidepool/Loop/Loop Widget Extension/DerivedAssetsOverride.xcassets" "${WORKSPACE_DIRECTORY}/Loop/Loop Widget Extension/DerivedAssetsOverride.xcassets"

"${WORKSPACE_DIRECTORY}/Loop/Scripts/build-derived-assets.sh" "${WORKSPACE_DIRECTORY}/Loop/Loop" &> /dev/null
"${WORKSPACE_DIRECTORY}/Loop/Scripts/build-derived-assets.sh" "${WORKSPACE_DIRECTORY}/Loop/WatchApp" &> /dev/null
"${WORKSPACE_DIRECTORY}/Loop/Scripts/build-derived-assets.sh" "${WORKSPACE_DIRECTORY}/Loop/Loop Widget Extension" &> /dev/null

cd ${WORKSPACE_DIRECTORY}
