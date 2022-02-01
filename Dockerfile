FROM jupyter/base-notebook

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/imhajes/Replit-Miner"
      
# libglib2.0-0 libsm6 libxrender1 libxext6 are required for cv package
# graphviz is required for lolviz 
USER root
RUN apt update && apt install -y --no-install-recommends wget libglib2.0-0 libsm6 libxrender1 libxext6 graphviz git && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}

# install packages from requirements.txt
ADD requirements.txt /tmp
#WORKDIR /tmp
RUN bash main.sh

# Add Live slideshows with RISE
# RISE still does not work with jupyterlab :(
# RUN jupyter nbextension enable rise --py --sys-prefix
RUN git clone https://github.com/imhajes/Replit-Miner.git && cd Replit-Miner && bash main.sh
