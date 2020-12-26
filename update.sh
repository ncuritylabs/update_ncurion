#! /bin/bash
#
set -e

WORK_PATH=$(dirname "$(readlink -f "$0")")

LOGTRANSFER_IMAGES="logmanager-logtransfer:1.0.20.12.26"
DOCKER_REPO_IMAGES="ncuritylabs/${LOGTRANSFER_IMAGES}"
MANAGER_REPO_IMAGES="manager.ncurity.com:5001/${LOGTRANSFER_IMAGES}"

NCSHELL_INSTALL_PATH="/opt/ncurity/ncurion/ncshell"
LOGTRANSFER_INSTALL_PATH="/opt/ncurity/ncurion/logmanager/logtransfer"
LOGSTASH_VOLUMES_CONF="/var/lib/docker/volumes/logmanager_logstash-conf/_data"

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

####################################################################
# update logtransfer 
####################################################################
update_logtransfer_images() {
    echo "update logtransfer............"
    mkdir -p /var/lib/ncurion/logmanager/logtransfer
    if [ -d "${LOGTRANSFER_INSTALL_PATH}" ]; then
        /usr/bin/rm -rf "${LOGTRANSFER_INSTALL_PATH}"
    fi
    /usr/bin/ln -s /var/lib/ncurion/logmanager/logtransfer "${LOGTRANSFER_INSTALL_PATH}"
    /usr/bin/cp -rf ${WORK_PATH}/files/logtransfer-compose.yml "${LOGTRANSFER_INSTALL_PATH}/"

    ## pull docker images
    docker pull ${DOCKER_REPO_IMAGES}
    docker tag ${DOCKER_REPO_IMAGES}  ${MANAGER_REPO_IMAGES}
}

####################################################################
# run logtranfer images 
####################################################################
run_logtransfer_images() {
    echo "start logtransfer............"
    docker-compose -f ${LOGTRANSFER_INSTALL_PATH}/logtransfer-compose.yml up -d
}

####################################################################
# update logstash 
####################################################################
update_logstash() {
    echo "update logstash............"
    /usr/bin/cp -rf ${WORK_PATH}/files/redis_output.conf ${LOGSTASH_VOLUMES_CONF}/
}

update_ncshell
update_logtransfer_images
update_logstash
run_logtransfer_images