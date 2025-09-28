FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && wget -qO /tmp/install.sh https://cdn-earnapp.b-cdn.net/static/earnapp/install.sh \
    && bash /tmp/install.sh -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp \
    && earnapp stop

WORKDIR /app
COPY . .

RUN chmod 755 hostnamectl && mv hostnamectl /usr/local/bin

VOLUME [ "/etc/earnapp" ]
ENTRYPOINT ["sh", "/app/run.sh"]
