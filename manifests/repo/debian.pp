# Class: jenkins::repo::debian
#
class jenkins::repo::debian
{
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include stdlib
  include apt

  if $::jenkins::lts  {
    apt::source { 'jenkins':
      location    => 'https://pkg.jenkins.io/debian-stable',
      release     => 'binary/',
      repos       => '',
      key         => '62A9756BFD780C377CF24BA8FCEF32E745F2C3D5',
      key_source  => 'https://pkg.jenkins.io/debian/jenkins.io.key',
      include_src => false,
    }
  }
  else {
    apt::source { 'jenkins':
      location    => 'https://pkg.jenkins.io/debian',
      release     => 'binary/',
      repos       => '',
      key         => '62A9756BFD780C377CF24BA8FCEF32E745F2C3D5',
      key_source  => 'https://pkg.jenkins.io/debian/jenkins.io.key',
      include_src => false,
    }
  }

  anchor { 'jenkins::repo::debian::begin': } ->
    Apt::Source['jenkins'] ->
    anchor { 'jenkins::repo::debian::end': }
}
