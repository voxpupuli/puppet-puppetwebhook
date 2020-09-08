# @summary Handle configuration of Webhook server.
#
type Puppetwebhook::Serverconfig = Struct[{
  server_type          => Enum['simple', 'daemon'],
  host                 => Stdlib::IP::Address,
  logfile              => Stdlib::Absolutepath,
  loglevel             => Enum['WARN', 'INFO', 'DEBUG', 'ERROR'],
  pidfile              => Stdlib::Absolutepath,
  port                 => Stdlib::Port,
  enable_ssl           => Boolean,
  Optional[ssl_verify] => Boolean,
  Optional[ssl_cert]   => Stdlib::Absolutepath,
  Optional[ssl_key]    => Stdlib::Absolutepath,
}]
