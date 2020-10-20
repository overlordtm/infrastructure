FROM debian:buster-slim

RUN useradd -ms /bin/bash -U -u 1000 sledilnik

COPY docker/install-packages.sh /
RUN /install-packages.sh && rm /install-packages.sh

COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp

ARG KUBECTL_VERSION="v1.19.0"
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
   mv ./kubectl /usr/local/bin/kubectl && \
   chmod +x /usr/local/bin/kubectl

ARG HELM_VERSION="v3.3.4"
RUN DESIRED_VERSION=${HELM_VERSION} curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

USER sledilnik

COPY requirements.yml .
RUN ansible-galaxy install -r requirements.yml

WORKDIR /sledilnik-infra
COPY . /sledilnik-infra/