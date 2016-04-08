# cyberoam-bash-script
Bash script to login, keep session alive and logout from a cyberoam server.
Usage: cyberoam-client <username>
The script saves the passwords for all the accounts it uses in configuration files in ~.
It also traps ctrl-c i.e. SIGINT and understands it as the signal to logout. So, you can run it in background and send it SIGINT using `kill -INT pid`.

_cclient:
This is the autocomplete file for bash. It detects all saved usernames and autocompletes them.
In order to use it, add ". path/_cclient" to your ".bashrc" file, where the path is to your local copy of _cclient.
Also, if you plan to change the name of the cyberoam-client script, make that same change in the last line in _cclient by replacing "complete -F _cyberoam_client cyberoam-client" with "complete -F _cyberoam_client new_name".