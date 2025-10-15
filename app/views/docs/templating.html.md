## Templating

Providentia has templating engine, which is using [Liquid](https://shopify.dev/api/liquid) language as base.

Main use case is using dynamic variables in `Network` or `VirtualMachine` fields, allowing for greater flexibility in designing the environment.

Currently, following variables can be used:

1. `actor_nr` - the number of Blue team, as iterated over the environment maximum
1. `actor_nr_str` - the number of Blue team, as iterated over the environment maximum, leftpadded with zeroes.
1. `team_nr` - legacy version of `actor_nr`
1. `team_nr_str` - legacy version of `actor_nr_str`
1. `seq` - sequential number, if a `VirtualMachine` is configured with a custom deploy count.

### Network

When `{{ actor_nr }}` or `{{ actor_nr_str }}` is added to compatible field (domain, cloud ID, network address), the network is switched to be in numbered mode. Any virtual machine attached to this network will be forced to deploy in "one per each actor entry" mode.

### Filters

Commonly used filter patterns, when current actor entries count equals _5_:

| Pattern                                     | Description                                                                        | Resulting values             |
| ------------------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------- |
| 10.{{ actor_nr }}.1.0/24                    | basic substitution                                                                 | 10. **[1-5]** .1.0/24        |
| a:b:c:d:12{{ actor_nr_str }}::/80           | leftpad equivalent, makes the substitution always be 2 characters, with 0 in front | a:b:c:d:12 **[01-05]** ::/80 |
| 100.64.{{ actor_nr &vert; plus: 200 }}.0/24 | offset applied to addressing, allows for more efficient use of address space       | 100.64. **[201-205]** .0/24  |
