{% set minion_to_node = {'node1': 1, 'node2': 2, 'node3': 3} %}
{% set node = salt['grains.get']('id') %}  # Get the minion ID

{% for minion, zk_id in minion_to_node.items() %}
{% if node == minion %}

create_zookeeper_dir_{{ node }}:
  file.directory:
    - name: /var/lib/zookeeper
    - makedirs: True
    - user: root
    - group: root
    - mode: 755

create_myid_file_{{ node }}:
  file.managed:
    - name: /var/lib/zookeeper/myid
    - contents: 'myid={{ zk_id }}'
    - user: root
    - group: root
    - mode: 755

{% endif %}
{% endfor %}
