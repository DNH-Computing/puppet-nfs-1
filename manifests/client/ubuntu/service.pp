class nfs::client::ubuntu::service {

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }

  # This should probably be less than something but xenial seems to be doing strange things
  if $lsbdistcodename != 'xenial' {
    if $nfs::client::ubuntu::nfs_v4 {
      service { 'idmapd':
        ensure    => running,
        enable    => true,
        subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
      }
    } else {
      service { 'idmapd':
        ensure => stopped,
        enable => false,
      }
    }
  }
}
