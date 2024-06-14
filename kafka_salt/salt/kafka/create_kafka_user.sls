create_kafka_user:
  user.present:
    - name: kafka
    - home: /home/kafka
    - shell: /bin/bash