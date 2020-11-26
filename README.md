# ansible-guac-setup

[![CI](https://github.com/mboehm21/ansible-guac-setup/workflows/CI/badge.svg?event=push)](https://github.com/mboehm21/ansible-guac-setup/actions?query=workflow%3ACI)

## Purpose
This project demonstrates some key-features of [Ansible](https://www.ansible.com/) to provision a demo-application (clientless remote desktop gateway [Apache Guacamole](https://guacamole.apache.org/)) on a [Docker](https://www.docker.com/)-host.
## Showcased features
- [Assertion of conditions](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L3-L8)
- [Package-management (apt and pip)](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L10-L26)
- [Linux user- and file-management](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L28-L60)
- [Copying of files](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L62-L78)
- [Templating](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L80-L96)
- [Managegement of services](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L98-L103)
- [Handling of docker-compose](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L105-L111)
- [Waiting for an event](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L103-L120)
- [Error-handling (rescue-block)](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L122-L168)
- [Working with APIs](https://github.com/mboehm21/ansible-guac-setup/tasks/main.yml#L122-L412)
## Prerequisites
- Install Ansible on your controller (`pip3 install ansible`)
- Install linters on your controller (`pip3 install yamllint ansible-lint`, optional)
- Add your Docker-server to the group `guacamole_hosts` in the [hosts](https://github.com/mboehm21/ansible-guac-setup/playbooks/hosts)-file and remove `localhost`
- Ensure Ansible's public-key is present at the Docker-server and the remote-user has sudo-permissions
- Test the access using `ansible -b -m ping guacamole_hosts`
## Usage
- Overwrite the [default](https://github.com/mboehm21/ansible-guac-setup/defaults/main.yml)-settings in [provision.yml](https://github.com/mboehm21/ansible-guac-setup/provision.yml) if needed
- Run the playbook (step by step for demonstration): `ansible-playbook --step provision.yml`
## Tags
| Tag             | Action                                                                   |
|:---------------:|--------------------------------------------------------------------------|
| `<none>`        | Deploy Guacamole and terminalserver-containers according to configuation |
| `teardown`      | Destroy Docker-containers and -volumes                                   |
| `teardown-full` | Destroy Docker-containers, volumes and the created file-struture         |

## Best Practices
Before using this in production some changes should be made to the setup:
- Use features like [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) to encrypt sensitive variables
- Use a local trusted Docker-registry instead of Docker Hub
- Use a central user-management like LDAP for both Guacamole and the terminalservers instead of the local database
- Use a reverse-proxy with TLS termination like an [nginx container](https://hub.docker.com/_/nginx) in front of Guacamole

Use [yamllint](https://github.com/adrienverge/yamllint) and [Ansible Lint](https://ansible-lint.readthedocs.io/) to check the playbooks and roles when changes are made:

```bash
mboehm21@dws-mboehm21:/var/mboehm21.guacamole_rdp$ yamllint . && ansible-lint 
./tasks/main.yml
  141:201   warning  line too long (229 > 200 characters)  (line-length)
  172:201   warning  line too long (206 > 200 characters)  (line-length)
  198:201   warning  line too long (238 > 200 characters)  (line-length)
  214:201   warning  line too long (238 > 200 characters)  (line-length)
  246:201   warning  line too long (212 > 200 characters)  (line-length)
  324:201   warning  line too long (212 > 200 characters)  (line-length)
  382:201   warning  line too long (212 > 200 characters)  (line-length)
  392:201   warning  line too long (238 > 200 characters)  (line-length)
```
