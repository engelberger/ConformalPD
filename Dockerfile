FROM mambaorg/micromamba:focal-cuda-11.3.1
USER root

# Key for CUDA repository
# RUN apt-key del 7fa2af80
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

#? Update repository sources list
RUN apt-get update
RUN apt install -y software-properties-common
# RUN apt-get install -y libxml2 cuda-minimal-build-11-3 libcusparse-dev-11-3 libcublas-dev-11-3 libcusolver-dev-11-3 
RUN apt-get install -y autotools-dev autoconf make build-essential 

#? NOTE: Required by matplotlib
RUN apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN apt-get install -y git wget curl 

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -y python3.9 python3-pip
RUN pip3 install poetry

COPY pyproject.toml /pyproject.toml
RUN poetry config virtualenvs.in-project true
RUN python3.9 -m pip install "transformers[torch]" loguru scipy datasets