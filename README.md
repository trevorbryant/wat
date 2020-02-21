# Wireless Auditing Tookit (WAT)
<div style="text-align:center"><img src="https://i.imgur.com/IppKJ.jpg" /></div>

## Description
The Wireless Auditing Toolkit (WAT) was created to be an enjoyable learning project for Radio Frequencies (RF). WAT is currently scoped for the [802.11](https://en.wikipedia.org/wiki/IEEE_802.11) protocols. As the project matures so will this description detailing the build (hardware and software), use cases, and usage examples. 

The WAT Playbook will install and configure the following:

  - Add `127.0.0.1` to `/etc/ansible/hosts` file
  - Enable `ufw`, configure logging, and allow incoming SSH
  - Harden SSH config
  - Dependencies from `apt`
  - Security tools from `apt`
  - Security tools from `pip3`
  - [kismet](https://github.com/kismetwireless/kismet)
  - [bully](https://github.com/aanarchyy/bully)
  - [hcxdumptool](https://github.com/ZerBea/hcxdumptool)
  - [hcxtools](https://github.com/ZerBea/hcxtools)
  - [hashcat-utils](https://github.com/hashcat/hashcat-utils)
  - Download target wordlists 

## Environment
This was built and tested for:
* [Ubuntu Server 19.10](https://wiki.ubuntu.com/EoanErmine/ReleaseNotes) (select OpenSSH during installation)
* [Ubuntu Desktop 19.10](https://wiki.ubuntu.com/EoanErmine/ReleaseNotes)

However, this is anticipated to work on versions 19.04. 18.04/10 will require more applications built from source.

## Dependencies
Packages to be installed prior to executing the playbook.

```bash
$ apt update
$ apt -y install python-apt ansible
```

## Examples
Perform a dry run:
```bash
$ sudo ansible-playbook wifi.yml --check
```

List tasks or tags:
```bash
$ sudo ansible-playbook wifi.yml --list-tasks
```

Install or skip specific tags or tasks (useful on desktop versions):
```bash
$ sudo ansible-playbook wifi.yml --tags "deb-utils,kismet"
$ sudo ansible-playbook wifi.yml --skip-tags "deb-sec,bully"
```

Run playbook and all install tools to localhost:

```bash
$ sudo ansible-playbook wifi.yml
```
