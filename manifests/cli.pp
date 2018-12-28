#
# Executes an arbitrary JBoss-CLI command
#   `[node-type=node-name (/node-type=node-name)*] : operation-name ['('[name=value [, name=value]*]')'] [{header (;header)*}]`.
#   This define is a wrapper for `wildfly_cli` that defaults to your local Wildfly installation.
#
# @param command The actual command to execute.
# @param unless If this parameter is set, then this `cli` will only run if this command condition is met.
# @param onlyif If this parameter is set, then this `cli` will run unless this command condition is met.
# @param username Wildfly's management user to be used internally.
# @param password The password for Wildfly's management user.
# @param host The IP address or FQDN of the JBoss Management service.
# @param port The port of the JBoss Management service.
define wildfly::cli(
  String $command          = $title,
  Optional[String] $unless = undef,
  Optional[String] $onlyif = undef,
  String $username         = $wildfly::mgmt_user['username'],
  String $password         = $wildfly::mgmt_user['password'],
  String $host             = $wildfly::properties['jboss.bind.address.management'],
  String $port             = $wildfly::properties['jboss.management.http.port'],
) {

  wildfly_cli { $title:
    command  => $command,
    username => $username,
    password => $password,
    host     => $host,
    port     => $port,
    unless   => $unless,
    onlyif   => $onlyif,
    require  => Service['wildfly'],
  }

}
