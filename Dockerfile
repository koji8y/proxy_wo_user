FROM ubuntu:24.04 as builder

ARG proxy
ENV HOME=/root
ENV http_proxy=$proxy
ENV https_proxy=$proxy
ENV HTTP_PROXY=$proxy
ENV HTTPS_PROXY=$proxy

RUN : set proxy \
  && set -ex \
  && rm -f /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && (test -z "$proxy" || echo 'Acquire::http::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf) \
  && (test -z "$proxy" || echo 'Acquire::https::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf)
RUN : install requred packages \
  && set -ex \
  && apt update \
  && apt upgrade -y
RUN : install requred packages for build \
  && apt install -y build-essential
RUN : install requred packages for build 2 \
  && apt install -y wget
WORKDIR /root
RUN : build stone \
  && wget https://www.gcd.org/sengoku/stone/stone-2.4.tar.gz \
  && tar zxf stone-2.4.tar.gz
WORKDIR /root/stone-2.4
RUN : build stone 2 \
  && make linux \
  && strip stone

FROM ubuntu:24.04 as proxy_wo_user
COPY --from=builder /root/stone-2.4/stone /usr/bin/stone
COPY stone.sh /root
WORKDIR /root
CMD ["/root/stone.sh"]
