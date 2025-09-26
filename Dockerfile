FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && wget -qO /install.sh https://cdn-earnapp.b-cdn.net/static/earnapp/install.sh \
    && bash /install.sh -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp /install.sh \
    && earnapp stop

WORKDIR /app
COPY . .

ENTRYPOINT ["/app/run.sh"]
