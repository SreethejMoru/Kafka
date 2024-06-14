# /srv/salt/kafka.sls

install_java:
  pkg.installed:
    - name: java-1.8.0-amazon-corretto.x86_64


