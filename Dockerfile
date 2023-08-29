FROM alpine:latest
EXPOSE 8080
WORKDIR /app
COPY . /app
ENV WEB_USERNAME=admin
ENV WEB_PASSWORD=admin*2023*
ENV ARGO_AUTH=eyJhIjoiYWQ1NDUwYTgyNTI0M2VhZTE5Y2E0ODI4MWQxNTRiZjIiLCJ0IjoiMDY2NTU2MjAtYWE0NS00YTAwLWIwYjMtMTAzYzg1NWZlNWVhIiwicyI6Ik5EVTVZMkUxTW1RdE5qUm1PUzAwWmpNM0xUazJOamN0TW1JeE5tTmxZVEEwTmpBeCJ9
ENV UUID=0e059fce-d6c8-4cc2-9e11-9efff358f8b9
ENV PORT=8080
RUN apk add --no-cache shadow \
    && groupadd sudo \
    && useradd -m choreouser -u 10014 \
    && echo 'choreouser:10014' | chpasswd \
    && usermod -aG sudo choreouser

RUN chown -R choreouser:choreouser / 2>/dev/null || true

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip wget bash shadow
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
RUN mv cloudflared-linux-amd64 cloudflared
RUN chmod +x cloudflared
RUN wget https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64
RUN mv ttyd.x86_64 ttyd
RUN chmod +x ttyd
RUN mkdir /tmp/xray && \
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
unzip /tmp/xray/xray.zip -d /tmp/xray && \
install -m 755 /tmp/xray/xray /app && \
rm -rf /tmp/xray

CMD bash /configure.sh
USER 10014
