#!/bin/bash

set -e

sudo /bin/chown ou:100 /home/ou/MetadataTutorial-3


ou-container-content startup


if [[ ! -z "${JUPYTERHUB_API_TOKEN}" ]]; then
    export JUPYTERHUB_SINGLEUSER_APP='jupyter_server.serverapp.ServerApp'
    exec jupyterhub-singleuser
else
    exec jupyter server
fi


ou-container-content shutdown
