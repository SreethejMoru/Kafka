create_zookeeper_user:
  user.present:
    - name: zookeeper
    - home: /home/zookeeper
