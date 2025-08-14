<div align="center">
<p>Clarified Security built <a href="https://clarifiedsecurity.com/tools/">tools</a>:</p>
<h3>
  <a href="https://providentia.sh">Providentia</a> &bull;
  <a href="https://catapult.sh">Catapult</a> &bull;
  EXPO
</h3>

---

![Providentia image](/app/assets/images/providentia.jpg)

</div>

[Providentia](https://providentia.sh) manages the inventory of your cyber exercise/lab/infrastructure environment: networks, hosts and more. The powerful JSON API can be used a single, centralized source of truth for rest of your toolset. Works best with [Catapult](https://catapult.sh).

## Quickstart

To get Providentia up and running with decent defaults you could use [a quickstart shell script](quickstart.sh), which downloads the required Docker compose files, the initial Zitadel SSO configuration and generates minimum required configuration.

Requirements:

- `wget` or `curl` for downloading
- `docker`
- `docker compose` plugin (version > 2)

```bash
curl https://raw.githubusercontent.com/ClarifiedSecurity/Providentia/refs/heads/main/quickstart.sh | sh
```

The last step of the script asks if you want to run Providentia locally or exposed over the network. If you are testing by yourself, local mode is easier and will expose the application at [https://providentia.localhost]. In network mode, you will be asked the domain suffix - if you pick "demo" here, the application will be accessible at [https://providentia.demo]. This configuration will be stored in `.env` file, which Docker Compose reads when starting the containers.

> [!NOTE]
> If you are using networked mode, ensure that you have DNS records pointing to the machine or `/etc/hosts` for everyone involved contain the correct entries. Be warned! Changing the mode _will_ break the ZITADEL configuration.

### Demo credentials

**Zitadel**:

- u: `zitadel-admin@localhost` p: `Password1!`

**Providentia**:

On first boot, a sample environment is created for you - "Test exercise" along with users with varied permissions. The setup mimics a typical cyber-defense actor pattern and creates users with varied permissions:

| Username              | Password   | Permissions                                                                                         |
| --------------------- | ---------- | --------------------------------------------------------------------------------------------------- |
| providentia.noaccess  | Password1! | Cannot login.                                                                                       |
| providentia.admin     | Password1! | Superadmin, has access to everything.                                                               |
| providentia.teadmin   | Password1! | Access to Test Exercise as environment administrator (all permissions).                             |
| providentia.rt        | Password1! | Access to Test Exercise as RT member (can see public machines, can see and alter RT VMs).           |
| providentia.dev       | Password1! | Access to Test Exercise as GT member (can see public machines, can see and alter infra and bt VMs). |
| providentia.bt        | Password1! | Access to Test Exercise as BT member (can see public machines, can see BT VMs).                     |
| providentia.personal1 | Password1! | Can login, cannot see any environments, can create personal environments.                           |
| providentia.personal2 | Password1! | Can login, cannot see any environments, can create personal environments.                           |
| providentia.personal3 | Password1! | Can login, cannot see any environments, can create personal environments.                           |

## Deploying

> [!CAUTION]
> The quickstart setup above set up is _not suitable_ for production use.

It is recommended to use the `providentia` Ansible role at [nova.core](https://github.com/novateams/nova.core) to deploy Providentia for production environments.

Providentia requires certain external resources to be functional:

- OpenID Connect provider for authentication, for example [Zitadel](https://github.com/zitadel/zitadel) or [Keycloak](https://github.com/keycloak/keycloak)
- PostgreSQL database - included in the Ansible role, but can be replaced with an external instance
- A reverse proxy, [Caddy](https://github.com/caddyserver/caddy) used in examples

## Development

Additional requirements:

- `make`
- `python3`

> [!IMPORTANT]
> In development mode, the user who is cloning the repository should also be the one building the image and running Providentia in order to avoid file permission errors. Do not run the following commands as root, unless you know exactly what you are doing.

First steps:

1. Configure by running `make config` (will be run automatically if makevars file is missing)
2. Build the container images with `make build`
3. Run the app with `make start`

   The local directory will be mounted in the container in development mode.

TL;DR:

```sh
git clone https://github.com/ClarifiedSecurity/Providentia.git
cd Providentia
make config
make build
make start
```

After bootup, Providentia can be accessed at [http://providentia.localhost](http://providentia.localhost) and Zitadel admin UI will be running at [http://zitadel.localhost](http://zitadel.localhost). The [demo credentials](#demo-credentials) can be used to log in.

## Features

The main use case is consuming the API to create [Ansible](https://www.ansible.com/) inventory in order to deploy networks and hosts to a virtualization environment. Since its creation in 2020, Providentia has been used to plan and deploy numerous Locked Shields (LS), Crossed Swords (XS) and other non-public cyber exercises.

- Can be used to manage infrastructure, defensive or offensive exercises
  - Supports multiple identical cloned environments for each actor
- Planning and design of exercise networking
  - Templating engine, allowing for value substitution in addresses, domains, etc.
  - Supports multiple address pool within same layer 2
  - Supports multiple NIC-s per host
  - Avoids address conflicts and overlaps
  - Supports static, dynamic, virtual addressing
- Hosts inventory: virtual machines, containers and physical devices
- Enabled describing detailed services, which can be used to perform automatic checks
  - Powerful pattern matching to easily apply services to multiple hosts at once
  - Flexible configuration for individual checks
- Authentication handled by external SSO via OpenID Connect
- JSON API, with accompanying Ansible inventory plugin as part of [nova.core](https://github.com/novateams/nova.core) collection

## Roadmap / planned features

- Rebuild access control for more flexibility
- UI overhaul for virtual machines/hosts
- Cluster mode management
- DNS zones management
- Credentials management
- Import/Export of environments

## Credits

Providentia was created and is maintaned by [mromulus](https://github.com/mromulus).

Thanks to [Clarified Security](https://clarifiedsecurity.com) for enabling this work to continue.

<p align="center">
  <a href="https://clarifiedsecurity.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/393247/223430817-82d6422c-9fe0-4836-a401-6eb0f588dc7a.png">
      <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/393247/223430780-9072ba4b-8c7c-4d55-8f5a-a8107d7cce00.png">
      <img alt="Clarified Security logo" src="https://user-images.githubusercontent.com/393247/223430780-9072ba4b-8c7c-4d55-8f5a-a8107d7cce00.png">
    </picture>
  </a>
</p>

## License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

For commercial support and consulting, contact us at [info@clarifiedsecurity.com](mailto:info@clarifiedsecurity.com)
