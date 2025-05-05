apache2:
  pkg.installed

/etc/apache2/sites-available/files.com.conf:
  file.managed:
    - source: salt://fileserver/files.com.conf

/home/vagrant/lan/files.com:
  file.directory:
    - makedirs: True

/etc/apache2/sites-enabled/000-default.conf:
  file.absent

/etc/apache2/sites-enabled/files.com.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/files.com.conf

apache_restart:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/files.com.conf

/etc/ufw/user.rules:
  file.managed:
    - source: salt://fileserver/user.rules

/etc/ufw/user6.rules:
  file.managed:
    - source: salt://fileserver/user6.rules

reload-ufw:
  cmd.wait:
    - name: ufw reload
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules