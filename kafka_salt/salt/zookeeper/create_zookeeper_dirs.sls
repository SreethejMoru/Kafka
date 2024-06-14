create_zookeeper_data_dir:
  file.directory:
    - name: /opt/zookeeper-3.8.4/data
    - user: zookeeper
    - group: zookeeper
    - mode: 755
    - makedirs: True


create_zookeeper_log_dir:
  file.directory:
    - name: /opt/zookeeper-3.8.4/logs
    - user: zookeeper
    - group: zookeeper
    - mode: 777
    - makedirs: True

      

create_zookeeper_conf_dir:
  file.directory:
    - name: /opt/zookeeper-3.8.4/conf
    - user: zookeeper
    - group: zookeeper
    - mode: 755
    - makedirs: True
