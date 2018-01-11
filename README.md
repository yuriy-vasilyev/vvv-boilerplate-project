Boilerplate project to use for creating new sites in VVV2.

Steps to make:
1. Add a new record into `vvv-custom.yml` like

    myawesomesite:
        hosts:
          - myawesomesite.test

Of course, you can add a repo link here, extra hosts, etc.

2. Duplicate the boilerplate folder into `vagrant-local/www`
3. Rename the new folder to `myawesomesite`.
4. Run `vagrant reload --provision`.

You can also edit `vvv-init.sh` as you want.
For example, add some licenses you have (as PHP constants starting from line 23 as extra PHP code),
extra wp-cli commands, etc.

Enjoy!
