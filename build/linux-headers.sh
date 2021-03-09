#!/bin.sh
architecture=""
case $(dpkg --print-architecture) in
    amd64)   architecture="amd64" ;;
    i686)   architecture="686" ;;
    armhf)  architecutre="armmp" ;;
esac
echo -n $architecture
