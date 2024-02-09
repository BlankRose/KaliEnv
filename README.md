<!-- Github Link: https://github.com/BlankRose/KaliEnv -->
<h1 align='center'><b>KaliEnv</b></h1>

This is minimal Dockerized [KaliLinux](https://www.kali.org/) desktop environnement, which can be accessed then via a [RDP (Remote Desktop Protocol)](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol)
client for one's quick various needs, without the hassle of setting up a whole complete [Virtual Machine](https://en.wikipedia.org/wiki/Virtual_machine).

*Warning: Docker environnements isnt as safe as Virtual Machines!*

------------------

# Requirements

- Only Linux is supported
- Docker Engine: https://docs.docker.com/engine/install/
- Any RDP Client (like [Remmina](https://remmina.org/))

------------------

# Basic Setup

A script is provided along with the Dockerfile for simplifying the steps to get it up running, and thus a simple call: `kali.sh start` is needed to get it all up and running.

Once ready, all you need to do is to connect with the RDP client of your choice at `127.0.0.1:5500`, with user `kali` and password `kali`, being the default values.

------------------

# Advanced Utilities

The script also provides some other commands, which can be used to ease out on manipulating other aspects of the dockerized environnement: `kali.sh [COMMAND]`

Command        | Shorthand     | Description
---------------|---------------|---------------------------------
`help`         | `h`           | Shows help message
`start`        | `s`           | Build, starts (or just resume) the container
`stop`         | `e`           | Stops the container
`clear`        | `c`           | Stops, and clears the container
`reset`        | `r`           | Calls, in order, `stop`, `clear` and `start`

------------------

# Shared Folders

By exporting the environnement variable `KALI_VOLUMES`, you can define a list, seperated by
commas, of volumes to setup on the creation on the environnement. Each element are represented
as such:

`host:container` where `host` is the path on the local machine and `container` is the path in
the dockerized KaliLinux.

You can also add a third argument to define wheter Kali can read, or write (`host:container:permission`)
with the following valid values:
- `ro`: Read Only
- `rw`: Read Write (Default)

*Note: For the docker expert out there, and those who knows how to use volumes: the whole string
is seperated at commas and then passed, whole, to the option `-v` of `docker run` and as such,
you can use all availables features volumes may offer*

------------------

# Customizing

You can freely customize the behaviours, such the port, or the login by exporting the following environnement variables:

Name           | Default       | Description
---------------|---------------|---------------------------------
`KALI_TAG`     | `kalienv`     | Tag used to reference the docker image
`KALI_NAME`    | `kali`        | Name of the generated container
`KALI_PORT`    | `5500`        | Access port for accessing the desktop environnement
`KALI_USER`    | `kali`        | Name of the user created on first initialization
`KALI_PASS`    | `kali`        | Password of the user created on first initialization
`KALI_ENV`     | `i3`          | Name of the desktop environnement ([kali-desktop-`$KALI_ENV`](https://www.kali.org/tools/kali-meta/))
`KALI_INSTALL` |               | List seperated by commas, of additional packages to initialize with
`KALI_VOLUMES` |               | List seperated by commas, which defines volumes to setup
`KALI_ATTACH`  |               | When defined, on start it will runs on foreground instead
