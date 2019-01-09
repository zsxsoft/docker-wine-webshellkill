# docker-wine-webshellkill

docker-wine-webshellkill 可以使你通过 Wine 在 Docker 容器中运行 WebShellKill。

即使该 Dockerfile 仓库使用 GPL 发布，其中下载的软件仍然遵循其最终用户使用许可协议，请确认同意协议后再进行下载使用。


## 下载使用

如果你在服务器上使用 `docker` 或者和 docker 兼容的服务，只需执行：

```bash
docker pull zsxsoft/webshellkill
mkdir webshellkill && cd webshellkill
docker run --rm -p 9000:9000 -v `pwd`:/home/user/data webshellkill
```

即可运行一个 WebShellKill 实例。运行后，访问 `http://你的IP:9000` 可以打开一个 VNC 页面，输入 `MAX8char` 作为密码后即可看到一个WebShellKill已经启动。


## 环境变量

在创建 docker 容器时，使用以下环境变量，可以调整容器行为。

* **`VNC_PASSWD`** 设置 VNC 密码。注意该密码不能超过 8 个字符。
* **`WEBSHELLKILL_URL`** 设置下载 酷Q 的地址，默认为 `http://d99net.net/down/WebShellKill_V2.0.9.zip` 。
