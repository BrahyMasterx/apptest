FROM alpine:latest
EXPOSE 8080
WORKDIR /app
COPY . /app

RUN apk add --no-cache shadow .build-deps ca-certificates curl unzip bash shadow \
    && groupadd sudo \
    && useradd -m choreouser -u 10014 \
    && echo 'choreouser:10014' | chpasswd \
    && usermod -aG sudo choreouser

RUN chown -R choreouser:choreouser / 2>/dev/null || true

RUN mkdir /tmp/xray && \
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
unzip /tmp/xray/xray.zip -d /tmp/xray && \
install -m 755 /tmp/xray/xray /app && \
rm -rf /tmp/xray

CMD bash /app/configure.sh
USER 10014
