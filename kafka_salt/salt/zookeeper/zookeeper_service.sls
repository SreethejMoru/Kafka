{% set zookeeper_service_content = '''
[Unit]
Description=Apache Zookeeper server
Documentation=http://zookeeper.apache.org
Requires=network.target
After=network.target

[Service]
Type=forking
User=zookeeper
Group=zookeeper
ExecStart=/opt/zookeeper/bin/zkServer.sh start
ExecStop=/opt/zookeeper/bin/zkServer.sh stop
ExecReload=/opt/zookeeper/bin/zkServer.sh restart
Restart=on-failure

[Install]
WantedBy=multi-user.target
''' %}

create_zookeeper_service_file:
  file.managed:
    - name: /etc/systemd/system/zookeeper.service
    - contents: |
        {{ zookeeper_service_content | indent(8) }}

reload_systemd_daemon_zookeeper:
  cmd.run:
    - name: systemctl daemon-reload
    - watch:
      - file: create_zookeeper_service_file

enable_zookeeper_service:
  service.running:
    - name: zookeeper
    - enable: True
    - watch:
      - file: create_zookeeper_service_file
      - cmd: reload_systemd_daemon_zookeeper
