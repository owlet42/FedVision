#!/bin/bash
set -e

source_code_dir=$(cd ..;pwd)

docker build -t federatedai/fedvision -f ${source_code_dir}/docker-build/Dockerfile ${source_code_dir}