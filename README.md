# Cyberoam Bash Script
Bash script to login, keep session alive and logout from a cyberoam server, with autocomplete.

<h4>Usage:</h4>
`cyberoam-client [-v] { [-q] [-d|-s] <username> | -l } `

`-d` : delete configuration file (if found) for username

`-s` : save configuration file (override if already exists) for username

`-q` : Be quiet i.e. don't send notifications of events

`-l` : logout. Other way to logout is to send ctrl-c i.e. SIGINT to the running process of cyberoam-client.

`-v` : give verbose output.

If `-s` is not specified, then if config file for username exists it is used otherwise the login info is not stored.

The script traps `ctrl-c` i.e. `SIGINT` and interprets it as the signal to logout. So, you can run it in background and send it `SIGINT` using `kill -INT pid`.

<h4>_cclient (autocomplete):</h4>

This is the autocomplete file for bash. It detects all saved usernames and autocompletes them.
In order to use it, add `. path/_cclient` to your `.bashrc` file, where the path is to your local copy of _cclient.
Also, if you plan to change the name of the `cyberoam-client` script, make that same change in the last line in `_cclient` by replacing `complete -F _cyberoam_client cyberoam-client` with `complete -F _cyberoam_client <new_name>`.
