# CI/CD runner playbook

This playbook builds self-hosted GitHub Actions runners that build and test OpenNMS Horizon and Meridian for the Bluebird-Community organization.
It also deploys the Maven CDN hosts.
The roles support Ubuntu 24.04 and 26.04.

## Roles

The `cicd_runner` play applies these roles in order.

| Role | What it does |
|---|---|
| `system-settings` | Limits, sysctl, timezone, build tools and the `cicd` user. |
| `tailscale` | Tailscale repository, package and service. Login is manual. |
| `docker-engine` | Docker repository and engine. |
| `prometheus.prometheus.node_exporter` | Node exporter from the Prometheus collection. |
| `monitoring` | chrony, APT update metrics, pmacct flow export and the Net-SNMP agent. |
| `container-builder` | Trivy, syft, dive and hadolint. |
| `java-builder` | OpenJDK, Maven and a seed Maven `settings.xml`. |
| `nodejs-builder` | Node.js from NodeSource, yarn and node-gyp. |
| `vm-builder` | Packer and QEMU. |
| `opennms` | OpenNMS repositories, JICMP, JRRD2 and Debian packaging tools. |
| `github-actions-runner` | Runner install, registration, service unit and cleanup hooks. |

The `mvn_cdn` play applies `docker-engine` and `mvn-cdn`.

## Requirements

- ansible-core 2.15 or newer.
- Collections `community.general`, `ansible.posix` and `prometheus.prometheus`.
- An inventory with the groups `cicd_runner` and `mvn_cdn`. The `inventory/` directory is not committed.

## Variables you must set

The role defaults are placeholders.
Set the real values in `inventory/group_vars/cicd_runner.yml` and `inventory/host_vars/<host>.yml`.
Both stay outside the repository.

```yaml
# group_vars/cicd_runner.yml
monitoring_pmacctd_interface: eth0
monitoring_pmacctd_interface_index: 2
monitoring_pmacctd_version: 10
monitoring_pmacctd_collector_ip: 192.0.2.10
monitoring_pmacctd_collector_port: 9999
monitoring_snmpd_community: change-me
monitoring_snmpd_inform_community: public

# host_vars/<host>.yml
monitoring_pmacctd_mac: "00:00:5e:00:53:01"
```

Optional switches:

| Variable | Default | Meaning |
|---|---|---|
| `system_manage_hosts_file` | `false` | Let the role write `/etc/hosts`. |
| `system_manage_dns` | `false` | Let the role write `/etc/systemd/resolved.conf`. |
| `openjdk_versions` | `[17, 25]` | JDK versions to install. |
| `openjdk_default_version` | `17` | JDK used for `java` and `JAVA_HOME`. |
| `nodejs_major_version` | `24` | Node.js major version. |

## Running the playbook

Always pass `--limit`.
The play fails on a host without a registered runner unless you pass a registration token.

Check first:

```sh
ansible-playbook -i inventory/<file> runner-playbook.yaml --limit <host> --check --diff
```

Then apply while the runner is idle:

```sh
gh api orgs/Bluebird-Community/actions/runners --jq '.runners[] | [.name, .status, .busy] | @tsv'
ansible-playbook -i inventory/<file> runner-playbook.yaml --limit <host>
```

A change to the runner unit or its `.env` restarts the runner.
A restart ends a running job.

## Adding a runner

1. Add the host to the `cicd_runner` group and set its host variables.
2. Create a registration token. It expires after one hour.

   ```sh
   gh api -X POST orgs/Bluebird-Community/actions/runners/registration-token --jq .token
   ```

3. Run the playbook with the token.

   ```sh
   ansible-playbook -i inventory/<file> runner-playbook.yaml --limit <host> -e gh_runner_token=<token>
   ```

4. Log the host in to Tailscale with `tailscale up`.

The runner name is the inventory host name.

The install path of the runner role has not run on a real host yet.
cicd-02 and cicd-03 were registered before the role managed the runner, so only the path for a registered runner is proven.
Expect to fix small things the first time you add a runner.

## Manual steps

- **Tailscale login.** The role installs Tailscale and does not log in.
- **After an Ubuntu release upgrade.** The upgrade disables third-party APT sources. Run the playbook to restore them, then run `apt full-upgrade` on the host while the runner is stopped. The roles install packages and do not upgrade them.

## Decisions

- **deb822 repositories.** Third-party repositories use `ansible.builtin.deb822_repository`. `apt-key` is gone in Ubuntu 26.04, and `.sources` files survive release upgrades better than `.list` files.
- **Run-time registration token.** The runner role takes a short-lived token on the command line. No registration token or personal access token is stored in the repository, the inventory or on the host. The runner keeps its own credentials in `/opt/actions-runner` after registration.
- **No re-registration.** The install path runs only when `/opt/actions-runner/.runner` is missing. A registered runner is never reinstalled or renamed. The runner version in the defaults is used for the first install only, because the runner updates itself.
- **Unit name.** The service keeps the name GitHub's `svc.sh` uses, `actions.runner.<org>.<host>.service`.
- **JDK.** 17 is the default and 25 is installed beside it. Jobs select 25 through `JAVA_HOME`.
- **Maven settings.** The role only seeds `~/.m2/settings.xml`. `actions/setup-java` rewrites the file in every job.
- **Host values stay outside the repository.** Collector addresses and SNMP communities are deployment data.
