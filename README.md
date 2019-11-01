# Wireless Auditing Tookit (WAT)
![WAT](https://i.imgur.com/IppKJ.jpg "WAT")

## Description
The Wireless Auditing Tookit (WAT) is currently only an Ansible Playbook to install the wireless auditing tools necessary post Operating System installation. As the project matures there will be description of the purpose, hardware selections, use cases, et cetera. WAT is intended to be an enjoyable learning project for Radio Frequencies (RF).

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
This was built and tested on:
* [Ubuntu Server 19.10](https://wiki.ubuntu.com/EoanErmine/ReleaseNotes)
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
