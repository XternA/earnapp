FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && printf '#!/bin/sh \n echo "%s"' "$(lsb_release -a)" > /usr/bin/lsb_release \
    && printf '#!/bin/sh \n echo "%s"' "$(hostnamectl)" > /usr/bin/hostnamectl \
    && printf '#!/bin/sh \n echo "%s"' "$(systemctl)" > /usr/bin/systemctl \
    && chmod +x /usr/bin/install /usr/bin/hostnamectl /usr/bin/lsb_release /usr/bin/systemctl \
    && wget -qO /tmp/install.sh https://cdn-earnapp.b-cdn.net/static/earnapp/install.sh \
    && bash /tmp/install.sh -y \
    && earnapp stop \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp

WORKDIR /app
COPY . .

VOLUME [ "/etc/earnapp" ]
ENTRYPOINT ["sh", "/app/run.sh"]
