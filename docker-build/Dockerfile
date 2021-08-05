FROM python:3.7 as builder
USER root
WORKDIR /data/projects/fedvision/
ENV PYTHONPATH=/data/projects/fedvision/FedVision:/data/projects/fedvision/FedVision/deps/PaddleDetection:/data/projects/fedvision/FedVision/deps/PaddleFL/python
RUN set -eux && \
cd /data/projects/fedvision && \
git clone --recursive https://github.com/FederatedAI/FedVision && \
python -m pip install -U pip && \
pip install -r FedVision/requirements.txt && \
pip install -r FedVision/requirements_dev.txt && \
python FedVision/tools/protobuf.py build 

RUN set -eux && \
cd FedVision/deploy/deploy_tookit && \
export PYTHONPATH=$(pwd) && \
python fedvision_deploy_toolkit/_build.py && \
pip install pep517 && \
python -m pep517.build . 



FROM python:3.7
USER root

WORKDIR /data/projects/fedvision/

COPY --from=builder /data/projects/fedvision/FedVision/deploy/deploy_tookit/fedvision_deploy_toolkit/data/fedvision.tar.gz /data/projects/fedvision/

RUN set -eux && \
    cd /data/projects/fedvision/ && \
    tar -xf fedvision.tar.gz -C /data/projects/fedvision && \
    rm -f fedvision.tar.gz
    
RUN set -eux && \
    bash -c " \
    python3 -m venv venv && source venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r /data/projects/fedvision/FedVision/requirements.txt \
    "


ENV PYTHONPATH=/data/projects/fedvision/FedVision:/data/projects/fedvision/FedVision/deps/PaddleDetection:/data/projects/fedvision/FedVision/deps/PaddleFL/python
