{% set directories = {'rebel_1': '/home/ec2-user/Zookeeper_node', 'rebel_1': '/home/ec2-user/Zookeeper_node', 'rebel_1': '/home/ec2-user/Zookeeper_node'} %}
{% set dir = directories[grains['id']] %}

replace_zoo_cfg:
  file.managed:
    - name: {{ dir }}/apache-zookeeper-3.9.2-bin/conf/zoo.cfg
    - source: salt://zookeeper/files/zoo.cfg.jinja
    - template: jinja
    - user: ec2-user
    - group: ec2-user
    - mode: 644
