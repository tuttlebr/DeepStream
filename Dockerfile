ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y \
    gcc \
    git-svn \
    jupyter \
    wget \
    zip

WORKDIR /opt/nvidia/deepstream/deepstream/samples/configs/

RUN git svn clone https://github.com/NVIDIA-AI-IOT/deepstream_reference_apps/trunk/deepstream_app_tao_configs \
    && cp deepstream_app_tao_configs/* tao_pretrained_models/ \
    && rm -rf deepstream_app_tao_configs/ \
    && tao_pretrained_models/download_models.sh