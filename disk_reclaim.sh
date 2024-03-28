#!/bin/bash

DISTRO="Ubuntu-22.04"

cycle_space()
{
    # Delete tar file previously created
    echo "Delete tar file previously created"
    echo "rm -rf ${DISTRO}.tar" && rm -rf ${DISTRO}.tar
    echo

    # Create a tar with the same name as the distro
    echo "Create a tar with the same name as the distro"
    echo "wsl --export ${DISTRO} ./${DISTRO}.tar" && wsl --export ${DISTRO} ./${DISTRO}.tar
    echo

    # Shutdown all WSL instances to unregister
    echo "Shutdown all WSL instances to unregister"
    echo "wsl --shutdown" && wsl --shutdown
    echo

    # Wait to ensure completion of shutdown
    echo "Wait to ensure completion of shutdown"
    echo "sleep 30" && sleep 30
    echo

    # Unregister distro
    echo "Unregister distro"
    echo "wsl --unregister ${DISTRO}" && wsl --unregister ${DISTRO}
    echo

    # Re-register distro with all saved data, but disk space claimed
    echo "Re-register distro with all saved data, but disk space claimed"
    echo "wsl --import ${DISTRO} ../wsl/ubuntu/ ./${DISTRO}.tar" && wsl --import ${DISTRO} ../wsl/ubuntu/ ./${DISTRO}.tar
    echo

    # Delete created tar file
    echo "Delete created tar file"
    echo "rm -rf ${DISTRO}.tar" && rm -rf ${DISTRO}.tar
    echo

    echo "Done"
}

echo "This script will terminate and unregister your Ubuntu WSL ditro, then reinstall it to reclaim disk space."
echo "Do you want to continue?"
while true; do
    read -p "[Y/y] Yes / [N/n] No: " yn
    case $yn in
        [Yy]* ) cycle_space ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer [Y]es or [N]o.";;
    esac
done

