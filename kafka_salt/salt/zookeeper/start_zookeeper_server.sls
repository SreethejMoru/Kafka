start_zookeeper:
  cmd.run:
    - name: sudo bin/zkServer.sh start
    - cwd: /home/ec2-user/Zookeeper_node/apache-zookeeper-3.9.2-bin
