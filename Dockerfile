FROM debian:bookworm-slim AS deps
ARG UID GID
RUN echo "makedebuggable:x:$GID:" >>/etc/group && useradd --uid $UID --gid makedebuggable makedebuggable
RUN apt-get update && apt-get install --no-install-recommends -y python3 zipalign apksigner && rm -rf /var/lib/apt/lists/*
COPY keygen.sh /scripts/
COPY makeDebuggable.py /scripts/

FROM scratch
COPY --from=deps / /
WORKDIR /home/makedebuggable
