FROM jupyter/base-notebook

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/alperyilmaz/jupyterlab-binder"
      
# libglib2.0-0 libsm6 libxrender1 libxext6 are required for cv package
# graphviz is required for lolviz 
USER root
RUN apt update && apt install -y --no-install-recommends libglib2.0-0 libsm6 libxrender1 libxext6 graphviz git && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}

# install packages from requirements.txt
ADD requirements.txt /tmp
#WORKDIR /tmp
RUN pip install -r /tmp/requirements.txt

# Add Live slideshows with RISE
# RISE still does not work with jupyterlab :(
# RUN jupyter nbextension enable rise --py --sys-prefix
RUN jupyter labextension install @ijmbarr/jupyterlab_spellchecker
