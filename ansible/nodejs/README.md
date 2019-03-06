## nodejs
 
[![Build Status](https://travis-ci.org/Oefenweb/ansible-nodejs.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-nodejs) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nodejs-blue.svg)](https://galaxy.ansible.com/Oefenweb/nodejs)

Set up the latest version of [Node.js](https://nodejs.org) and [npm](https://www.npmjs.com) in Debian-like systems.

#### Requirements

* `python-apt`
* `curl` (will be installed)

#### Variables

* `nodejs_version` [default: `nodejs-v6x`]: Version to install (e.g. `nodejs-v10x`, `nodejs-v9x`, `nodejs-v8x`, `nodejs-v7x`, `nodejs-v6x`, `nodejs-v5x`, `nodejs-v012`, `nodejs-v010`, `iojs-v3x`, `iojs-v2x`, `iojs-v1x`)

* `nodejs_install` [default: `[build-essential]`]: Packages to install

* `nodejs_npm_packages`: [default: `[]`]: Node.js packages to install (globally)
* `nodejs_npm_packages.{n}.name`: [required]: The name of the package
* `nodejs_npm_packages.{n}.version`: [optional]: The version of the package

## Dependencies

None

## Recommended

* `ansible-yarn` ([see](https://github.com/Oefenweb/ansible-yarn))

#### Example

```yaml
---
- hosts: all
  roles:
    - nodejs
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-nodejs/issues)!
