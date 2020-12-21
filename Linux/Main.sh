#!/bin/bash

./PAM.sh
echo "PAM files script has been ran"

./RemoveBadSoftwares.sh
echo "Bad softwares have been removed"

./Users.sh
echo "Users have been fixed"
