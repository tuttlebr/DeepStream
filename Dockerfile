ARG BASE_IMAGE
FROM ${BASE_IMAGE} 

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ARG MAKEFLAGS=-j$(nproc) 

#
# Install runtime dependencies
#
RUN apt-get update \
    && apt-get -yq install --no-install-recommends \
        curl \
        git-svn \
        python3-dev \
        python3-pip \
        python3-setuptools \
        unzip \
        wget 

#
# Install nodejs for nv_dashboard
#
RUN curl -sL "https://deb.nodesource.com/gpgkey/nodesource.gpg.key" | apt-key add - \
    && echo "deb https://deb.nodesource.com/node_14.x focal main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get -yq update \
    && apt-get -yq install --no-install-recommends \
    nodejs

#
# Install the jupyter* packages
#
RUN pip3 install --upgrade pip \
    && pip3 install \
    jupyter \
    jupyterlab \
    jupyterlab_nvdashboard

#
# Create non-root user with UID=1000 in the 'users' group
#
ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_PREFIX /
ENV HOME /home/$NB_USER

RUN useradd -M -s /bin/bash -N -u ${NB_UID} ${NB_USER} \
    && chown -R ${NB_USER}:users /usr/local/bin \
    && mkdir -p $HOME \
    && chown -R ${NB_USER}:users ${HOME} \
    && chown -R ${NB_USER}:users /opt/nvidia/deepstream/deepstream/samples/

SHELL ["/bin/bash", "-c"]

#
# Add additional streams, configs & models
#
WORKDIR /opt/nvidia/deepstream/deepstream/samples/streams
COPY streams/ .

WORKDIR /opt/nvidia/deepstream/deepstream/samples/configs/tao_pretrained_models
COPY tao_pretrained_models/ .
RUN ./download_models.sh

# USER ${NB_USER}