rename_zoo_sample_conf:
  cmd.run:
    - name: 'mv /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo_sample.cfg /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo.cfg'
    - cwd: /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf
    - creates: /home/admin/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo.cfg
    - require:
      - cmd: extract_zookeeper