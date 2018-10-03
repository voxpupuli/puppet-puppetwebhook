type Puppetwebhook::Serverconfig = Struct[{
  server_type => Enum['simple', 'daemon'],
  logfile     => Stdlib::Absolutepath,
  loglevel    => Enum['WARN', 'INFO', 'DEBUG', 'ERROR'],
  pidfile     => Stdlib::Absolutepath,
  port        => Stdlib::Port,
  enable_ssl  => Boolean,
  ssl_verify  => Boolean,
  ssl_cert    => Stdlib::Absolutepath,
  ssl_key     => Stdlib::Absolutepath,
}]
