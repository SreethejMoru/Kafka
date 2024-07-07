{% set directories = {'key_1': '/home/admin/Zookeeper_node', 'key_2': '/home/admin/Zookeeper_node', 'key_3': '/home/admin/Zookeeper_node'} %}
{% set dir = directories[grains['id']] %}

replace_zoo_cfg:
  file.managed:
    - name: {{ dir }}/apache-zookeeper-3.9.2-bin/conf/zoo.cfg
    - source: salt://zookeeper/files/zoo.cfg.jinja
    - template: jinja
    - context:
        cassandra_ips1: "{% for ip in salt['mine.get']('key_1', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
        cassandra_ips2: "{% for ip in salt['mine.get']('key_2', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
        cassandra_ips3: "{% for ip in salt['mine.get']('key_3', 'ipv4').values() %}{{ ip|replace('[','')|replace(']','')|replace("'", '') }}{% if not loop.last %},{% endif %}{% endfor %}"
    - user: admin
    - group: admin
    - mode: 644
