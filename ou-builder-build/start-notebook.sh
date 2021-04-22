#!/bin/bash

set -e


ou-container-content


if [[ ! -z "${JUPYTERHUB_API_TOKEN}" ]]; then
    exec jupyterhub-singleuser --ip=0.0.0.0 --port 8888 --NotebookApp.config_file=/etc/jupyter/jupyter_notebook_config.py
else
    exec jupyter notebook --NotebookApp.config_file=/etc/jupyter/jupyter_notebook_config.py
fi