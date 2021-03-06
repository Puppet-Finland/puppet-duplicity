# == Class: duplicity
#
# This class sets up duplicity.
#
# == Parameters
#
# [*manage*]
#   Whether to manage duplicity using Puppet. Valid values are true (default) 
#   and false.
# [*ensure*]
#   Status of duplicity. Valid values are 'present' (default) and 'absent'.
# [*gpg_key_id*]
#   The ID of the GPG key to use. Both the public and private keys are imported 
#   automatically from the Puppet fileserver. They need to named as
#   
#     <gpg_key_id>-public.key
#     <gpg_key_id>-private.key
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class duplicity
(
    String                   $gpg_key_id,
    Boolean                  $manage = true,
    Enum['present','absent'] $ensure = 'present',
    Optional[String]         $gpg_public_key_content = undef,
    Optional[String]         $gpg_private_key_content = undef,
    Optional[String]         $gpg_public_key_source = undef,
    Optional[String]         $gpg_private_key_source = undef,

) inherits duplicity::params
{

if $manage {

    include ::duplicity::prerequisites

    class { '::duplicity::install':
        ensure => $ensure,
    }

    class { '::duplicity::config':
        ensure                  => $ensure,
        gpg_key_id              => $gpg_key_id,
        gpg_public_key_content  => $gpg_public_key_content,
        gpg_private_key_content => $gpg_private_key_content,
        gpg_public_key_source   => $gpg_public_key_source,
        gpg_private_key_source  => $gpg_private_key_source,
    }
}
}
