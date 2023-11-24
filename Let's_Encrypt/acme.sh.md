## Simple acme.sh usage

* One Cpanel **addon web domain** (a web domain as organized in Cpanel).
* No web subdomain
* The addon web domain could act as a parked domain which is basically a landing page of the hosting provider suggesting the parked domain for sale. 

### Installing acme.sh

```shell
cd ${WEB_APPLICATION_ROOT_DIR}}
curl https://get.acme.sh | sh
acme.sh --issue --webroot . -d EXAMPLE.COM --staging # Is that a test for proper work of acme.sh?
acme.sh - debug # Check for acme.sh possible problems.
source ${HOME}/.bashrc # We source the file because the above installation adds data to it.
acme.sh --register-account --accountemail MY_EMAIL_ADDRESS_NAME@GMAIL.COM # Can gmail.com really be used here without a problem?
crontab -l | grep acme.sh#
acme.sh --issue --webroot . -d EXAMPLE.COM -d www.EXAMPLE.COM
acme.sh --deploy --deployhook . --domain EXAMPLE.COM --domain www.mydomain.com
```

### Uninstalling acme.sh

If installed as above, a uninstallation would include:

* Deleting `${HOME}/acme.sh`
* Deleting acme.sh data from the file `.bashrc`
* Deleting acme.sh data from the `crontab -l`.
