# netdata-speedtest
A Speedtest.net connection speed testing plugin for [netdata](https://github.com/netdata/netdata).

Just drop the script file into `/usr/libexec/netdata/charts.d/`, and Netdata will pick it up automatically. It creates a new chart under the System header, called Connection Speed. It tracks both down and upload speeds.

## Installation

This plugin requires the [speedtest.net cli](https://www.speedtest.net/apps/cli).

The speedtest.net license needs to accepted once by running `sudo -u netdata speedtest`.

## Configuration

None required, but you can modify Netdata's built-in parameter for testing frequency. Add a file called `/etc/netdata/charts.d/speedtest.conf`:
```
#!/bin/bash

# Update frequency, in seconds. Defaults to 600.
speedtest_update_every=600
```

## Testing
To make sure it works, use netdata's built-in debugging system. Run:

```
# become user netdata
sudo su -s /bin/sh netdata

# run the plugin in debug mode
/usr/libexec/netdata/plugins.d/charts.d.plugin debug 60 speedtest
```

For more information see the [netdata documentation](https://docs.netdata.cloud/collectors/charts.d.plugin/).
