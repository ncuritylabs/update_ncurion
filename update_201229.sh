#! /bin/bash
#
set -e

WORK_PATH=$(dirname "$(readlink -f "$0")")

NCSHELL_INSTALL_PATH="/opt/ncurity/ncurion/ncshell"

####################################################################
# update ncshell 
####################################################################
update_ncshell() {
    echo "update ncshell............"
    ## kill all ncshell processes
    local isInFile=`pidof ncshell`
    if [[ ! -z "${isInFile}" ]]; then
        kill -9 $(pidof ncshell)
    fi 

    ## copy ncshell
    /usr/bin/rm -rf "${NCSHELL_INSTALL_PATH}/bin/ncshell"
    /usr/bin/cp -rf ${WORK_PATH}/files/ncshell "${NCSHELL_INSTALL_PATH}/bin/"

    ## set permission
    chmod +x "${NCSHELL_INSTALL_PATH}/bin/ncshell"
}

update_ncshell
