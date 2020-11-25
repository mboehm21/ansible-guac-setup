# ansible-guac-setup
## Purpose
This project demonstrates some key-features of [Ansible](https://www.ansible.com/) to provision a demo-application (clientless remote desktop gateway [Apache Guacamole](https://guacamole.apache.org/)) on a [Docker](https://www.docker.com/)-host.
## Showcased features

TODO: FIX LINE NUMBERS

- [Assertion of conditions](/roles/provision_guac_rdp/tasks/main.yml#L3-L8)
- [Package-management (apt and pip)](/roles/provision_guac_rdp/tasks/main.yml#L3-L16)
- [Linux user- and file-management](/roles/provision_guac_rdp/tasks/main.yml#L18-L59)
- [Copying of files](/roles/provision_guac_rdp/tasks/main.yml#L61-L68)
- [Templating](/roles/provision_guac_rdp/tasks/main.yml#L70-L86)
- [Handling of docker-compose](/roles/provision_guac_rdp/tasks/main.yml#L88-L92)
- [Waiting for an event](/roles/provision_guac_rdp/tasks/main.yml#L94-L101)
- [Error-handling (rescue-block)](/roles/provision_guac_rdp/tasks/main.yml#L103-L149)
- [Working with APIs](/roles/provision_guac_rdp/tasks/main.yml#L103-L393)
## Prerequisites
- Install Ansible on your controller (`pip3 install ansible`)
- Install linters on your controller (`pip3 install yamllint ansible-lint`, optional)
- Add your Docker-server to the group `guacamole_hosts` in the [hosts](/hosts)-file and remove `localhost`
- Ensure Ansible's public-key is present at the Docker-server and the remote-user has sudo-permissions
- Test the access using `ansible -b -m ping guacamole_hosts`
## Usage
- Overwrite the [default](/roles/provision_guac_rdp/defaults/main.yml)-settings in [provision.yml](/provision.yml) if needed
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
mboehm21@dws-mboehm21:/var/ansible-guac-setup$ ./check_sanity.sh 
roles/provision_guac_rdp/tasks/main.yml
  124:201   warning  line too long (229 > 200 characters)  (line-length)
  155:201   warning  line too long (206 > 200 characters)  (line-length)
  181:201   warning  line too long (238 > 200 characters)  (line-length)
  197:201   warning  line too long (238 > 200 characters)  (line-length)
  229:201   warning  line too long (212 > 200 characters)  (line-length)
  307:201   warning  line too long (212 > 200 characters)  (line-length)
  365:201   warning  line too long (212 > 200 characters)  (line-length)
  375:201   warning  line too long (238 > 200 characters)  (line-length)

Ansible sanity-checks successful.
mboehm21@dws-mboehm21:/var/ansible-guac-setup$ echo $?
0
```
