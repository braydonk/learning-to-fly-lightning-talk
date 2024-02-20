FROM golang:1.22.0-bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install tools
RUN apt-get update && apt-get install -y git gnuplot jq less vim psmisc htop

# Change working directory to experiment
RUN mkdir -p experiment
WORKDIR "/experiment"

# Copy scripts and configs
COPY scripts scripts
COPY configs configs
COPY random_server random_server
COPY scenarios scenarios

# Build destination server
RUN cd random_server && \
    go build random_server.go && \
    cd ..

# OpenTelemetry Collector Contrib
RUN wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.94.0/otelcol-contrib_0.94.0_linux_amd64.tar.gz && \
    mkdir -p otelcol && \
    tar -xzf otelcol-contrib_0.94.0_linux_amd64.tar.gz -C ./otelcol && \
    rm otelcol-contrib_0.94.0_linux_amd64.tar.gz

# OpenTelemetry Collector Builder
RUN mkdir -p ocb
RUN cd ocb && \
    wget https://github.com/open-telemetry/opentelemetry-collector/releases/download/cmd%2Fbuilder%2Fv0.94.1/ocb_0.94.1_linux_amd64 && \
    mv ocb_0.94.1_linux_amd64 ocb && \
    chmod +x ocb && \
    cd .. && \
    ./ocb/ocb --config configs/build_otelsmol.yaml

# Node Exporter
RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz && \
    tar -xzf node_exporter-1.7.0.linux-amd64.tar.gz && \
    rm node_exporter-1.7.0.linux-amd64.tar.gz && \
    mv node_exporter-1.7.0.linux-amd64 node_exporter

# Avalanche
RUN git clone https://github.com/prometheus-community/avalanche.git avalanche-src && \
    cd avalanche-src/cmd && \
    go build avalanche.go && \
    mv avalanche /experiment && \
    cd ../..
