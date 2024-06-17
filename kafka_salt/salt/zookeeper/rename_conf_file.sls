rename_zoo_sample_conf:
  cmd.run:
    - name: mv /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo_sample.cfg /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo.cfg
    - cwd: /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf
    - creates: /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin/conf/zoo.cfg
