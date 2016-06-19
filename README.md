# Cyberoam Bash Script
Bash script for logging in, keeping session alive and logging out from a cyberoam server, with auto-completion of saved profiles, and auto-completion according to login state i.e. it will auto-complete to the logout parameter when the script daemon is already running.
The script is licensed under GPLv3.

###Usage:
`cyberoam-client [-v] [-q] [-s] <username> `

`cyberoam-client [-v] -l `

`cyberoam-client [-v] -d <username> `

`-d` : delete configuration file (if found) for username.

`-s` : save configuration file (override if already exists) for username. 
If `-s` is not specified, then saved config file for username is used (no input asked). If the config file doesn't exist, the login info needs to be inputted and is not stored.

`-q` : Be quiet i.e. don't send notifications of events.

`-l` : logout. Other way to logout is to send ctrl-c i.e. SIGINT to the running process of cyberoam-client.

`-v` : give verbose output.

The script traps `Ctrl+c` i.e. `SIGINT` and interprets it as the signal to logout. So, apart from running `cyberoam-client -l` you can send the running process a `SIGINT` using `kill -INT pid` (`pid` is the process id of the running `cyberoam-client` process) or, if it is in the foreground in your terminal, pressing `Ctrl+c`.

###Auto-complete:

`_cclient` is the auto-complete file for bash. It detects all saved usernames and auto-completes them. Also, if the script is already running, it auto-completes only -l, to facilitate logout.
In order to set up the functionality, add `. path/_cclient` to your `.bashrc` file, where the `path` is to your local copy of `_cclient`.
Also, if you plan to change the name of the `cyberoam-client` script, make that same change in all occurrences of it in `_cclient`.

###Tips:

* The interval between keep-alive requests, limit of failed login attempts and interval between failed login attempts can be adjusted by changing the values of the variables `ACK_INTERVAL`, `LOGIN_COUNT_MAX` and `LOGIN_ATTEMPT_INTERVAL` respectively.
* In order to make the script retry logging in indefinitely, set `LOGIN_COUNT_MAX` as -1.
