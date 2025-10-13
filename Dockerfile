FROM debian:trixie-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && printf '#!/bin/sh\necho "%s"' "$(lsb_release -a)" > /usr/bin/lsb_release \
    && printf '#!/bin/sh\necho "%s"' "$(hostnamectl)" > /usr/bin/hostnamectl \
    && printf '#!/bin/sh\necho "%s"' "$(systemctl)" > /usr/bin/systemctl \
    && chmod +x /usr/bin/lsb_release /usr/bin/hostnamectl /usr/bin/systemctl \
    && wget -qO /tmp/install.sh https://cdn-earnapp.b-cdn.net/static/earnapp/install.sh \
    && bash /tmp/install.sh -y \
    && earnapp stop \
    && rm -rf /var/lib/{apt,dpkg,cache,log} \
        /usr/share/{doc,man,info,locale,i18n} \
        /var/log/apt /var/tmp /var/cache/apt/* \
        /etc/apt \
        /tmp/*

WORKDIR /app
COPY . .

VOLUME [ "/etc/earnapp" ]
ENTRYPOINT ["sh", "/app/run.sh"]
