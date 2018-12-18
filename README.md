# User-Organizations CustomField Provider for Request Tracker

#### Table of Contents

1. [About](#about)
2. [License](#license)
3. [Support](#support)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Configuration](#configuration)

## About

Add custom field values based on user organizations. This helps to link customer to tickets by just maintaining
organizations for users. It will be a duplicate-free list created.

## License

This project is licensed under the terms of the GNU General Public License Version 2.

This software is Copyright (c) 2018 by NETWAYS GmbH <[support@netways.de](mailto:support@netways.de)>.

## Support

For bugs and feature requests please head over to our [issue tracker](https://github.com/NETWAYS/rt-extension-organizationalcustomfieldvalues/issues).
You may also send us an email to [support@netways.de](mailto:support@netways.de) for general questions or to get technical support.

## Requirements

- RT 4.4.2

## Installation

Extract this extension to a temporary location

Git clone:

```
cd /usr/local/src
git clone https://github.com/NETWAYS/rt-extension-organizationalcustomfieldvalues
```

Navigate into the source directory and install the extension.

```
perl Makefile.PL
make
make install
```

Clear your mason cache.

```
rm -rf /opt/rt4/var/mason_data/obj
```

Restart your web server.

```
systemctl restart httpd

systemctl restart apache2
```

## Configuration

Edit your `/opt/rt4/etc/RT_SiteConfig.pm` configuration and include the extension.

```
Plugin('RT::Extension::OrganizationalCustomFieldValues');
Set(@CustomFieldValuesSources, 'RT::Extension::OrganizationalCustomFieldValues');
```
