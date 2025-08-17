FROM debian:bullseye-slim

WORKDIR /app
RUN groupadd -r appgroup && useradd -r -m -g appgroup appuser

RUN apt-get update && apt-get install -y \
    curl \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sL https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bullseye main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update && apt-get install -y azure-cli=2.76.0-1~bullseye \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/azure-cli.list \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R appuser:appuser /app
USER appuser
CMD ["bash"]
