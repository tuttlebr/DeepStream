FROM nvcr.io/nvidia/deepstream-l4t:6.0-samples

ENV DEBIAN_FRONTEND=noninteractive
ENV MAKEFLAGS=-j$(nproc) 

WORKDIR /opt/nvidia/deepstream/deepstream/samples/configs/

RUN apt-get update \
    && apt-get install -y \
    git-svn \
    wget \
    zip \
    && git svn clone https://github.com/NVIDIA-AI-IOT/deepstream_reference_apps/trunk/deepstream_app_tao_configs \
    && cp deepstream_app_tao_configs/* tao_pretrained_models/ \
    && rm -rf deepstream_app_tao_configs/ \
    && /opt/nvidia/deepstream/deepstream-6.0/samples/configs/tao_pretrained_models/download_models.sh