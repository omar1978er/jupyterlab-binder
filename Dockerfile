FROM jupyter/base-notebook

# libglib is required for cv package
USER root
RUN apt update && apt install -y --no-install-recommends libglib2.0-0 libsm6 libxrender1 libxext6 graphviz && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}

# install packages from requirements.txt
ADD requirements.txt /tmp
#WORKDIR /tmp
RUN pip install -r /tmp/requirements.txt

# Add Live slideshows with RISE
# RISE still does not work with jupyterlab :(
# RUN jupyter nbextension enable rise --py --sys-prefix
RUN jupyter labextension install @ijmbarr/jupyterlab_spellchecker
