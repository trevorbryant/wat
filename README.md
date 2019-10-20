# Wireless Auditing Tookit (WAT)
![WAT](https://i.imgur.com/IppKJ.jpg "WAT")

## Description
The Wireless Auditing Tookit (WAT) is currently only an Ansible Playbook to install the wireless auditing tools necessary post Operating System installation.

## Environment
This was built and tested on [Ubuntu Server 19.10](https://wiki.ubuntu.com/EoanErmine/ReleaseNotes).

## Dependencies
Packages to be installed prior to executing the playbook.

```bash
$ apt update
$ apt -y install python-apt ansible
```

Perform a dry run:
```bash
$ sudo ansible-playbook server.yml --check
```

List tasks or tags:
```bash
$ sudo ansible-playbook server.yml --list-tasks
```

Install or skip specific tasks:
```bash
$ sudo ansible-playbook server.yml --tags "deb-utils,kismet"
$ sudo ansible-playbook server.yml --skip-tags "deb-sec,bully"
```

Run playbook and all install tools to localhost:

```bash
$ sudo ansible-playbook server.yml
```
