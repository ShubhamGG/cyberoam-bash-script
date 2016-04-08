# cyberoam-bash-script
Bash script to login, keep session alive and logout from a cyberoam server.
Usage: cyberoam-client ;ltusername;gt
The script saves the passwords for all the accounts it uses in configuration files in ~.
It also traps ctrl-c i.e. SIGINT and understands it as the signal to logout. So, you can run it in background and send it SIGINT using `kill -INT pid`.
