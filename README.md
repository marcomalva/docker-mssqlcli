# docker-mssqlcli

Docker image to run `msql-cli`, a python3 CLI for Microsoft Server. 

A couple of points:

* The docker image must be launched as interactive and with pseudo-TTY (`-it`)

* The docker image has a welcome message that shows how to launch the CLI 

* The Linux user `sqladmin` is created as used as the user within the docker image

* The Makefile picks the `docker` version/tag from the `Dockerfile`

* The Makefile uses `podman` instead of `docker` if installed to run seamlessly on Fedora 30+

  * One can overwrite the choice of container executable to use with environment variable `DOCKER`

* One can run `make print-version` to extract the version label, which equals to running

   `grep '^LABEL version=' Dockerfile | awk -F\= '{print $2}' | tr -d '"'`

## Required Packages for mssqlcli

* `python3-pip`: to use `pip` to install the application
* `mssql-cli`: the CLI application
* `wget` to get the Microsoft `.deb` file to install .NET packages

As for the .NET for Linux see:  [Install .NET on Ubuntu - .NET | Microsoft Docs](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2010-)

## Build

In order to build the docker image execute:

```bash
docker build -t "mssqlcli:0.1" -f Dockerfile-mssqlcli-ubuntu .
```

Or you could use the `Makefile` where the version number is derived from the `LABEL version=...` entry in the `Dockerfile`:

```bash
make build
```

The `Makefile` defaults to using `podman`, if installed. One can force the use of `docker` with:

```bash
DOCKER=docker make build
```

## Launch

One can launch the `mssqlcli` for the `docker` image with:

```bash
docker run -it "mssqlcli:0.1"
```

Inside the container run the following command, assuming that `172.31.44.147` the DB host IP and `admin` is the user name:

```bash
python3 -m mssqlcli.main -S 172.31.44.147 -U admin
```

## Links

### Source Code (mssql-cli)

* [dbcli/mssql-cli: A command-line client for SQL Server with auto-completion and syntax highlighting](https://github.com/dbcli/mssql-cli "https://github.com/dbcli/mssql-cli")

* [mssql-cli - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/tools/mssql-cli?view=sql-server-ver15 "https://docs.microsoft.com/en-us/sql/tools/mssql-cli?view=sql-server-ver15")

### Docker Best Practices

Articles that contributed to the Dockerfile:

* [10 best practices for creating good docker images | artindustrial it](https://www.artindustrial-it.com/2017/09/20/10-best-practices-for-creating-good-docker-images/ "https://www.artindustrial-it.com/2017/09/20/10-best-practices-for-creating-good-docker-images/")

* [non-root user inside a Docker container - Gerard Braad's blog](http://gbraad.nl/blog/non-root-user-inside-a-docker-container.html "http://gbraad.nl/blog/non-root-user-inside-a-docker-container.html")

* [python - docker-compose , PermissionError: [Errno 13] Permission denied: '/manage.py' - Stack Overflow](https://stackoverflow.com/questions/56784492/docker-compose-permissionerror-errno-13-permission-denied-manage-py "https://stackoverflow.com/questions/56784492/docker-compose-permissionerror-errno-13-permission-denied-manage-py")

* [linux - How to add users to Docker container? - Stack Overflow](https://stackoverflow.com/questions/27701930/how-to-add-users-to-docker-container "https://stackoverflow.com/questions/27701930/how-to-add-users-to-docker-container")

* [How can I get a docker container to load text from /etc/motd - Stack Overflow](https://stackoverflow.com/questions/31437858/how-can-i-get-a-docker-container-to-load-text-from-etc-motd "https://stackoverflow.com/questions/31437858/how-can-i-get-a-docker-container-to-load-text-from-etc-motd")

* [How to change welcome message (motd) on Ubuntu 18.04 server - LinuxConfig.org](https://linuxconfig.org/how-to-change-welcome-message-motd-on-ubuntu-18-04-server "https://linuxconfig.org/how-to-change-welcome-message-motd-on-ubuntu-18-04-server")

