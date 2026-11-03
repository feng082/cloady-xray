# 多阶段构建：从官方镜像复制二进制文件，解决官方镜像没有 shell 的报错
FROM ghcr.io/xtls/xray-core:latest AS xray-source

FROM alpine:latest

RUN apk add --no-cache ca-certificates tzdata

# 拷贝 xray 二进制和路由规则数据
COPY --from=xray-source /usr/bin/xray /usr/local/bin/xray
COPY --from=xray-source /usr/share/xray/ /usr/share/xray/

WORKDIR /etc/xray

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 默认端口与节点 UUID（可在部署平台环境变量中覆盖）
ENV PORT=8080
ENV UUID=a2a4b855-a710-4b35-bdfb-1511beb4fe71
ENV WSPATH=/vless

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
