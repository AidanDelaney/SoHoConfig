include apache

package{ "exim4-config":
  ensure => "installed"
}

group { "puppet":
   ensure => "present",
}

file { "/home/aidan":
  require => User["aidan"],
  ensure => "directory",
  owner  => "aidan",
  group  => "aidan",
  mode   => 755
}

user { "aidan":
  name     => "aidan",
  ensure   => "present",
  comment  => "Aidan Delaney",
  home     => "/home/aidan",
  password => str2saltedsha512("open123"),
}

ssh_authorized_key { "Aidan login key":
  require  => File["/home/aidan"],
  ensure   => "present",
  type     => "ssh-rsa",
  key      => "AAAAB3NzaC1yc2EAAAABIwAAAQEAsdlYmaL4nbBzRF48+5uCFDFMgfCVANzahbun2ZxyHHX1f8ab+MmKWxfL85/NnYEtp7caZf6OvcXXpG7uIywQJURSiDS4oqw27c5Kos4wbB99CPnWtQU8VgXodg8u+X4Ea1eHosSivb3Urjl73DlVPtjV+OwC+PVyZ0+U862F0tXO059F9S6qxZ2r+ZeZkOMLLUsWpm5M+8OZ44a9joHKRe2q5EodXOVCc0twoHXvL2hfykIwL0y3nMipJMDUNfFPv6cyvm6+NOamxS/1R2o+uHcFeAFFFErBbuXyMCdpvpgCWQwG2PuCSQz+sN7i4qv3o3WGhXcbBXZvq9N5DsSmKQ==",
  user     => "aidan"
}

# Make the apache docroot under my homedir
# Turn off php and all that lark.
apache::vhost { 'phoric.eu':
  require  => User['aidan'],
  port         => '80',
  docroot      => '/home/aidan/www',
  vhost_name   => '*',
}
