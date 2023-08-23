
FROM python:3.10-bullseye



ARG TARGETPLATFORM



ENV USER="ou"
ENV UID="1000"
ENV GID="100"
ENV MODULE_CODE="MetadataTutorial"
ENV MODULE_PRESENTATION="3"
ENV HOME="/home/$USER/$MODULE_CODE-$MODULE_PRESENTATION"
ENV SHELL="/bin/bash"
ENV CARGO_HOME="/opt/cargo"
ENV PATH="$PATH:/opt/cargo/bin"



USER root


RUN mkdir /home/$USER && \
    useradd -u $UID -g $GID -d $HOME -m -s /bin/bash $USER


RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tini

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


  



  



  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential gcc gnutls-dev libcurl3-gnutls libcurl3-gnutls libcurl3-gnutls-dev sudo
  



  
RUN pip install --no-cache-dir --extra-index-url=https://www.piwheels.org/simple "jupyter-server-proxy>=3.2.1,<4.0.0" "jupyter_server<4.0.0" "jupyterhub>=3.0.0,<4" "jupyterlab>=4.0.2,<5.0.0" "ou-container-content>=1.2.0" "polymatheia>=0.3.1" "pycurl" "pycurl" "scipy" "seaborn" 
  



  
RUN mkdir -p /etc/module-content/data
COPY ou-builder-build/content/content_config.yaml /etc/module-content/config.yaml
    
      
        
          
COPY content/_build/html /etc/module-content/data/.tutorial
          
        
      
        
          
COPY notebooks /etc/module-content/data/
          
        
      
        
          
COPY ou-builder-build/services/services.sudoers /etc/sudoers.d/99-services
          
        
      
        
          
COPY ou-builder-build/ou_core_config.json /usr/local/etc/jupyter/jupyter_server_config.json
          
        
      
        
          
COPY ou-builder-build/startup/start.sh /usr/bin/start.sh
          
        
      
        
          
COPY ou-builder-build/startup/home-dir.sudoers /etc/sudoers.d/99-home-dir
          
        
      
    
  



  
    
      
RUN chmod a+x /usr/bin/start.sh && \
    chmod 0660 /etc/sudoers.d/99-home-dir
      
    
      
RUN ou-container-content prepare
      
    
  





RUN chown -R $UID:$GID $HOME /etc/module-content


USER $USER


WORKDIR $HOME
ENTRYPOINT ["tini", "-g", "--"]



EXPOSE 8888



CMD ["start.sh"]
