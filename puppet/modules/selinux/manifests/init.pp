# == Class: selinux
#
#  This class manages SELinux on RHEL based systems.
#
# === Parameters:
#  [*mode*]
#    (enforced|permissive|disabled)
#    sets the operating state for SELinux.
#
#  [*installmake*]
#    make is required to install modules. If you have the make package declared
#    elsewhere, you want to set this to false. It defaults to true.
#
# === Requires:
#  - [puppetlab/stdlib]
#
# == Example
#
#  include selinux
#
class selinux(
  $mode = 'enforcing',
  $installmake = true,
  ) {
  include stdlib
  include selinux::params

  file { $selinux::params::modules_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  anchor { 'selinux::begin': } ->
  class { 'selinux::config':
      mode => $mode,
  } ->
  anchor { 'selinux::end': }
}
