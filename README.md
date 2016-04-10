# Cyberoam Bash Script
Bash script for logging in, keeping session alive and logging out from a cyberoam server, with autocompletion of saved profiles.

<h4>Usage:</h4>
`cyberoam-client [-v] { [-q] [-d|-s] <username> | -l } `

`-d` : delete configuration file (if found) for username

`-s` : save configuration file (override if already exists) for username

`-q` : Be quiet i.e. don't send notifications of events

`-l` : logout. Other way to logout is to send ctrl-c i.e. SIGINT to the running process of cyberoam-client.

`-v` : give verbose output.

If `-s` is not specified, then saved config file for username is used (no input asked). If the config file doesn't exist, the login info needs to be inputted and is not stored.

The script traps `Ctrl+c` i.e. `SIGINT` and interprets it as the signal to logout. So, apart from running `cyberoam-client -l` you can send the running process a `SIGINT` using `kill -INT pid` (`pid` is the process id of the running `cyberoam-client` process) or, if it is in the foreground in your terminal, pressing `Ctrl+c`.

<h4>_cclient (autocomplete):</h4>

This is the autocomplete file for bash. It detects all saved usernames and autocompletes them.
In order to use it, add `. path/_cclient` to your `.bashrc` file, where the `path` is to your local copy of `_cclient`.
Also, if you plan to change the name of the `cyberoam-client` script, make that same change in the last line in `_cclient` by replacing `complete -F _cyberoam_client cyberoam-client` with `complete -F _cyberoam_client <new_name>`.

Tips:

Provide proper execution permissions to the scripts using `chmod +x <file>` for both the script files before using them.

You can directly access the script by adding the path to its folder to the PATH env variable.
