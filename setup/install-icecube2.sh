#!/bin/sh

################################################################################
# Download file                                                                #
################################################################################
echo "Have you already downloaded the installation file? [y/N]"
while : ; do
    read -r response
    case "$response" in
        [yY]|[yY]es)
            is_downloaded=true
            break
            ;;
        [nN]|[nN]o)
            is_downloaded=false
            break
            ;;
        "")
            is_downloaded=false
            break
            ;;
        *)
            echo "Please enter a yes or no response"
            ;;
    esac
done

if [ "$is_downloaded" != "true" ]; then
    echo "Opening download location. Scroll to the bottom of the page and " \
         "click iCEcube2 2017-08 for Linux\" (or most recent version)"
    echo "If nothing appears, go to this website:"
    echo "http://www.latticesemi.com/iCEcube2"
    echo "Press any key to open URL..."
    read -r _
    /usr/bin/xdg-open "http://www.latticesemi.com/iCEcube2"
    echo "Press enter once you have downloaded the file to this location " \
         "($(pwd))"
    read -r _
fi

################################################################################
# Ensure setup file is downloaded
################################################################################
# https://stackoverflow.com/a/6364244
for f in ./iCEcube2setup*.tgz; do
    # Check if the glob gets expanded to existing files. If not, f here will be
    # exactly the pattern above and the exists test will evaluate to false.
    if [ ! -f "$f" ]; then
        echo "Did not find an iCEcube2setup*.tgz file. Please download from "
        echo "http://www.latticesemi.com/iCEcube2"
        exit 1
    fi

    ## This is all we needed to know, so we can break after the first iteration
    break
done
tar_file="$f"
setup_file="${f%.tgz}"

################################################################################
# Install all dependencies (that I know of)
################################################################################
printf "########################################"
printf "########################################\n"
printf "# Installing Dependencies               "
printf "                                       #\n"
printf "########################################"
printf "########################################\n"

sudo apt-get install zlib1g:i386 libxext6:i386 libpng12-0:i386 libsm6:i386 \
     libxi6:i386 libxrender1:i386 libxrandr2:i386 libxfixes3:i386 \
     libxcursor1:i386 libxinerama1:i386 libfreetype6:i386 libfontconfig1:i386
# Possibly add: libglib2.0-dev:i386

################################################################################
# Extract and run the downloaded installation file
################################################################################
printf "########################################"
printf "########################################\n"
printf "# Extracting and Installing iCEcube2    "
printf "                                       #\n"
printf "########################################"
printf "########################################\n"

tar xf "$tar_file"
./"$setup_file" || cat << EOF
Error occurred when executing iCEcube2 setup script.
Check this file ($0) for hints on how to fix this
EOF
