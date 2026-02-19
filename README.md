[![Docker Size](https://img.shields.io/docker/image-size/tzuhsiao/baidunetdisk)](https://hub.docker.com/r/tzuhsiao/baidunetdisk)
[![Docker Pulls](https://img.shields.io/docker/pulls/tzuhsiao/baidunetdisk)](https://hub.docker.com/r/tzuhsiao/baidunetdisk)

# Baidu NetDisk Docker

Run Baidu NetDisk (百度网盘) in a Docker container with VNC/web browser access.

**Features:**
- Based on Ubuntu 24.04 LTS
- Baidu NetDisk v4.17.7
- Multi-architecture support (amd64/arm64)
- Access via VNC or web browser

## Usage

```bash
docker run --name baidunetdisk \
  -v {config_folder}:/root/baidunetdisk \
  -v {download_folder}:/root/baidunetdiskdownload \
  -p {VNC_port}:5900 \
  -p {WEB_port}:6080 \
  -e VNC_SERVER_PASSWD='{VNC_password}' \
  tzuhsiao/baidunetdisk:latest
```

**Example:**
```bash
docker run --name baidunetdisk \
  -v ~/baidunetdisk/config:/root/baidunetdisk \
  -v ~/baidunetdisk/download:/root/baidunetdiskdownload \
  -p 5900:5900 \
  -p 6080:6080 \
  -e VNC_SERVER_PASSWD='password' \
  tzuhsiao/baidunetdisk:latest
```

### Access via VNC

Connect to port 5900 (default) using any VNC client such as [VNC® Viewer](https://www.realvnc.com/en/connect/download/viewer/) or [TightVNC](https://www.tightvnc.com/).

### Access via Web Browser

Open your browser and navigate to: `http://localhost:6080`

## Building

Build for your platform:
```bash
docker buildx build --platform linux/arm64 -t tzuhsiao/baidunetdisk:latest --load .
# or for amd64
docker buildx build --platform linux/amd64 -t tzuhsiao/baidunetdisk:latest --load .
```

Build for multiple platforms:
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t tzuhsiao/baidunetdisk:latest --push .
```

---

# 百度网盘 Docker

在 Docker 容器中运行百度网盘，支持 VNC/浏览器访问。

**特性：**
- 基于 Ubuntu 24.04 LTS
- 百度网盘 v4.17.7
- 支持多架构（amd64/arm64）
- 支持 VNC 或浏览器访问

## 使用方法

```bash
docker run --name baidunetdisk \
  -v {配置文件夹}:/root/baidunetdisk \
  -v {下载文件夹}:/root/baidunetdiskdownload \
  -p {VNC端口}:5900 \
  -p {WEB端口}:6080 \
  -e VNC_SERVER_PASSWD='{VNC密码}' \
  tzuhsiao/baidunetdisk:latest
```

**示例：**
```bash
docker run --name baidunetdisk \
  -v ~/baidunetdisk/config:/root/baidunetdisk \
  -v ~/baidunetdisk/download:/root/baidunetdiskdownload \
  -p 5900:5900 \
  -p 6080:6080 \
  -e VNC_SERVER_PASSWD='password' \
  tzuhsiao/baidunetdisk:latest
```

### 通过 VNC 访问

使用任何 VNC 客户端连接到端口 5900（默认），如 [VNC® Viewer](https://www.realvnc.com/en/connect/download/viewer/) 或 [TightVNC](https://www.tightvnc.com/)。

### 通过浏览器访问

打开浏览器访问：`http://localhost:6080`

## 构建镜像

构建指定架构镜像：
```bash
docker buildx build --platform linux/arm64 -t tzuhsiao/baidunetdisk:latest --load .
# 或者构建 amd64 版本
docker buildx build --platform linux/amd64 -t tzuhsiao/baidunetdisk:latest --load .
```

构建多架构镜像：
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t tzuhsiao/baidunetdisk:latest --push .
```
