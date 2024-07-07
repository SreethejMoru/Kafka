configure_kafka_node:
  file.managed:
    - name: /home/admin/kafka_node/kafka_2.13-3.7.0/config/server.properties
    - source: salt://kafka/server.properties.jinja
    - template: jinja
    - context:
        broker_id: {{ grains.get('id', '0') | replace('key_', '') | int }}
        kafka_node_ip1: "{% for ip in salt['mine.get']('key_1', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
        kafka_node_ip2: "{% for ip in salt['mine.get']('key_2', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
        kafka_node_ip3: "{% for ip in salt['mine.get']('key_3', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
    - user: admin
    - group: admin
    - mode: 755