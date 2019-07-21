#
# == Class: duplicity::config::gnupg
#
# GnuPG configuration for duplicity
#
class duplicity::config::gnupg
(
    Enum['present','absent'] $ensure,
    String                   $gpg_key_id,
    Optional[String]         $gpg_public_key_source,
    Optional[String]         $gpg_private_key_source
)
{

    $gnupg_defaults = {
        'ensure' => $ensure,
        'user'   => 'root',
        'key_id' => $gpg_key_id,
    }

    $l_gpg_public_key_source = $gpg_public_key_source ? {
        undef   => "puppet:///files/${gpg_key_id}-public.key",
        default => $gpg_public_key_source
    }

    $l_gpg_private_key_source = $gpg_private_key_source ? {
        undef   => "puppet:///files/${gpg_key_id}-private.key",
        default => $gpg_private_key_source
    }

    gnupg_key { 'duplicity-public-key':
        key_source => $l_gpg_public_key_source,
        key_type   => 'public',
        *          => $gnupg_defaults,
    }

    gnupg_key { 'duplicity-private-key':
        key_source => $l_gpg_private_key_source,
        key_type   => 'private',
        *          => $gnupg_defaults,
    }
}
