#!/bin/bash

###> Colors ###
RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
YELLOW_COLOR='\033[0;33m'
COLOR_OFF='\033[0m'
###< Colors ###

###> Checkout version ###
VERSION=$1
if [ ! "$VERSION" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provide version!"
    exit
fi
echo -e "Deploying ${YELLOW_COLOR}${VERSION}${COLOR_OFF}..."
VERSION_DEPLOYED=$(git describe --tags --abbrev=0 | grep "$VERSION")
if [ "$VERSION_DEPLOYED" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: this version has been already deployed"
    exit
fi
# Fetch actual
git fetch --tags
VERSION=$(git tag -l | grep "$VERSION")
if [ ! "$VERSION" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: version not found"
    exit
fi
# Checkout to updates
git pull
git checkout -q "${VERSION}"
###< Checkout version ###

###> Custom ###
# Specify your custom deploying code
###< Custom ###

echo  -e "${GREEN_COLOR}SUCCESS${COLOR_OFF}: ${VERSION} has been deployed!"
