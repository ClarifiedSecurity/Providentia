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

## Getting started

While it is possible to run Providentia on a host directly, the recommended approach is to use Docker containers and bundled Makefile. The requirements for this are:

- `make`
- `python3`
- `docker`
- `docker compose` plugin (version > 2)

First steps:

> [!IMPORTANT]
> In development mode, the user who is cloning the repository should also be the one building the image and running Providentia in order to avoid file permission errors. Do not run the following commands as root, unless you know exactly what you are doing.

0. Clone the repository
1. Configure by running `make config` (will be run automatically if makevars file is missing)

   This will ask if you need to use sudo for launching docker, which in most cases is yes.

2. Build the container images with `make build`
3. Run the app with `make start`

   The local directory will be mounted in the container in development mode.

> [!NOTE]
> Development mode only works on the machine it's launched on, it will not function over network!

TL;DR:

```sh
git clone https://github.com/ClarifiedSecurity/Providentia.git
cd Providentia
make config # choose dev
make build
make start
```

After bootup, Providentia can be accessed at [http://providentia.localhost](http://providentia.localhost) and Keycloak will be running at [http://keycloak.localhost](http://keycloak.localhost). You may need to trust the self-signed TLS certificate if running production mode.

### Components

Providentia is a [Ruby on Rails](https://github.com/rails/rails) based web application, but contains multiple containers by default:

- [Keycloak](https://github.com/keycloak/keycloak) for authentication (SSO)

  Can be switched to any OpenID Connect provider

- ~~Redis~~[Garnet](https://github.com/microsoft/garnet) for caching and session storage
- [PostgreSQL](https://www.postgresql.org/)
- [Rails](https://github.com/rails/rails) app
- [Caddy](https://github.com/caddyserver/caddy) reverse proxy

### Credentials

**Keycloak**:

- u: `admin` p: `adminsecret`

**Providentia**:

On first development mode boot, a sample environemnt is created for you - "Test exercise". The setup mimics a typical cyber-defense actor pattern and creates users with varied permissions:

- u: `providentia.noaccess` p: `pass` - cannot login.
- u: `providentia.admin` p: `pass` - superadmin, has access to everything.
- u: `providentia.teadmin` p: `pass` - has access to Test Exercise as environment administrator (all permissions)
- u: `providentia.rt` p: `pass` - has access to Test Exercise as RT member (can see public machines, can see and alter RT virtual machines).
- u: `providentia.dev` p: `pass` - has access to Test Exercise as GT member (can see public machines, can see and alter infra virtual machines and bt virtual machines).
- u: `providentia.bt` p: `pass` - has access to Test Exercise as BT member (can see public machines, can see BT virtual machines).
- u: `providentia.personal1` p: `pass` - can login, cannot see any environments, can create personal environments.
- u: `providentia.personal2` p: `pass` - can login, cannot see any environments, can create personal environments.
- u: `providentia.personal3` p: `pass` - can login, cannot see any environments, can create personal environments.

## Running in production

> [!CAUTION]
> Default production configuration is insecure! Be warned!

The make based bootstrap can be used to start the application in production mode as well. It is primarily meant to be inspiration on how a production environment might look like - it is **not** meant to be used without altering it first.

The steps for setting up are similar to dev instructions above, except answer 'prod' when prompted for environment. Have a look at `docker/prod` directory on how the setup works and adapt it to your needs using configuration files:

- web.env
- db.env
- docker-compose.yml
- initdb.sql

A good example on how Providentia could be deployed in production via ansible can be seen at [nova.core role](https://github.com/novateams/nova.core/tree/main/nova/core/roles/providentia)

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
