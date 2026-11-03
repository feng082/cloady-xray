# Cloady Xray Node (VLESS + WS + TLS)

本项目专用于在 [Cloady](https://cloady.com/) 免费容器云部署 Xray 节点。

## 解决的痛点
官方 `ghcr.io/xtls/xray-core` 镜像基于 scratch 构建，不包含 shell，导致 entrypoint 脚本执行报错 `no such file or directory`。
本项目采用 **多阶段 Dockerfile**，将官方编译好的二进制文件与规则库复制至 Alpine 镜像中，支持动态端口 `$PORT` 与环境变量注入。

## 默认配置
- **协议**: VLESS
- **传输层**: WebSocket (`/vless`)
- **默认 UUID**: `a2a4b855-a710-4b35-bdfb-1511beb4fe71`
- **TLS**: Cloady 边缘自带 HTTPS (443)

## 部署说明
1. 在 Cloady 后台新建应用，选择本 GitHub 仓库部署。
2. 区域务必选择 **US West (`usw1`)** 或 **US East (`use1`)** 免费区。
3. 部署完成后获取分配的域名 `your-app.cloady.io`。
4. 客户端配置：
   - 地址: `your-app.cloady.io`
   - 端口: `443`
   - UUID: `a2a4b855-a710-4b35-bdfb-1511beb4fe71`
   - 传输: `ws`
   - 路径: `/vless`
   - TLS: 开启
   - SNI: `your-app.cloady.io`
