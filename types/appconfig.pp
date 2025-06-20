#
# @summary custom type to enforce the config for the whole application
#
type Puppetwebhook::Appconfig = Struct[{
    protected                     => Boolean,
    user                          => String[1],
    pass                          => String[1],
    Optional[client_cfg]          => Stdlib::Absolutepath,
    Optional[client_timeout]      => String[1],
    Optional[use_mco_ruby]        => Boolean,
    use_mcollective               => Boolean,
    Optional[discovery_timeout]   => String[1],
    chatops                       => Boolean,
    Optional[chatops_service]     => Enum['slack', 'rocketchat'],
    Optional[chatops_channel]     => Pattern[/\A#.*/],
    Optional[chatops_user]        => String[1],
    Optional[chatops_url]         => Stdlib::HTTPUrl,
    default_branch                => String[1],
    Optional[ignore_environments] => Array[String[1]],
    Optional[prefix_command]      => String[1],
    r10k_deploy_arguments         => String[1],
    Optional[allow_uppercase]     => Boolean,
    Optional[command_prefix]      => String[1],
    Optional[prefix]              => String[1],
    Optional[github_secret]       => String[1],
    Optional[repository_events]   => Array,
}]
