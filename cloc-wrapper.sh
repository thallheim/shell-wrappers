#!/bin/bash
# shellcheck disable=3020

# Ensure sed is installed
if ! command -v sed &> /dev/null
then
    echo "ERR: Can't find sed, somehow. Now what?"
    exit 1
fi

# Ensure cloc is installed
if ! command -v cloc &> /dev/null
then
    echo "ERR: Can't find cloc. Is it installed?"
    exit 1
fi

# Check for lolcat, because why not
lc=false
if command -v lolcat &> /dev/null
then
    export lc=true
fi

# Call cloc and stash its output
cloc_output=$(cloc "$@" 2>&1)

# Extract GH link, version string, and stats
attrib=$(echo "$cloc_output" | grep 'github.com/AlDanial/cloc v')

# Strip link, version and stats
cloc_output_stripped=$(echo "$cloc_output" | sed "/github.com\/AlDanial\/cloc v/d")

# Reflow output, with pizzazz if lolcat is on $PATH
echo ""

if [ $lc = true ]
then
    echo "$attrib" |lolcat
    echo "-------------------------------------------------------------------------------" |lolcat
else
    echo "$attrib"
    echo "-------------------------------------------------------------------------------"
fi

echo "$cloc_output_stripped"
