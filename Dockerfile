FROM debian:bullseye-slim
LABEL maintainer "Chris Wells <iroh@cogito.io>"

ENV LANG C.UTF-8
ENV APP_DIR /app
ENV MC_VERSION latest

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        python3-pillow \
        python3-dev \
        python3-numpy \
        git \
        wget \
    ; \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${APP_DIR}

RUN set -eux; \
    git clone https://github.com/overviewer/Minecraft-Overviewer.git src/; \
    python3 src/setup.py build; \
    python3 src/setup.py install

VOLUME ${APP_DIR}/world ${APP_DIR}/html

ARG UNAME=minecraft
ARG UID=1000
ARG GID=1000
RUN set -eux; \
    groupadd -g ${GID} -o ${UNAME}; \
    useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

USER ${UNAME}

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD ["/usr/local/bin/docker-cmd.sh"]