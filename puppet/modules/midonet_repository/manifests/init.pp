#
class midonet_repository {

  define redhat_MEM($username,
    $password,
    $midonet_version = '1.7',
    $rhel_version = '7',
    $midonet_openstack_plugin_version = 'icehouse') {

    file {"/etc/yum.repos.d/midokura.repo":
      ensure => "file",
      path => "/etc/yum.repos.d/midokura.repo",
      content => template("midonet_repository/etc/yum.repos.d/midokura.repo.erb"),
      mode => "0644",
      owner => "root",
      group => "root",
    }
  }

  define ubuntu_MEM($username,
    $password,
    $midonet_version = '1.7',
    $midonet_openstack_plugin_version = 'icehouse') {

    package{ "curl":
       ensure => "latest"
    }
    ->
    exec {"${module_name}__install_package_key_on_osfamily_Debian":
      command => "/usr/bin/curl -k http://$username:$password@apt.midokura.com/packages.midokura.key | /usr/bin/apt-key add -",
      unless => "/usr/bin/apt-key list | /bin/grep 'info@midokura.jp'"
    }
    ->
    file {"/etc/apt/sources.list.d/midokura.list":
      ensure => "file",
      path => "/etc/apt/sources.list.d/midokura.list",
      content => template("midonet_repository/etc/apt/sources.list.d/midokura.list.erb"),
      mode => "0644",
      owner => "root",
      group => "root",
    }
  }

  define ubuntu_OSS($midonet_version = '2014.11',
    $midonet_openstack_plugin_version = 'juno') {

    package{ "curl":
       ensure => "latest"
    }
    ->
    exec {"${module_name}__install_package_key_on_osfamily_Debian":
      command => "/usr/bin/curl -k http://repo.midonet.org/packages.midokura.key | /usr/bin/apt-key add -",
      unless => "/usr/bin/apt-key list | /bin/grep 'ops@midokura.com'"
    }
    ->
    file {"/etc/apt/sources.list.d/midonet.list":
      ensure => "file",
      path => "/etc/apt/sources.list.d/midonet.list",
      content => template("midonet_repository/etc/apt/sources.list.d/midonet.list.erb"),
      mode => "0644",
      owner => "root",
      group => "root",
    }
  }

}

