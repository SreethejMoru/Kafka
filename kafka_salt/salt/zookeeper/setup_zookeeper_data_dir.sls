{% set minion_to_node = {'rebel_1': {'node1': 1, 'node2': 2, 'node3': 3}} %}
{% set node = salt['grains.get']('id') %}  # Get the minion ID

{% if node in minion_to_node['rebel_1'] %}
{% set zk_id = minion_to_node['rebel_1'][node] %}

# Ensure directory exists for Zookeeper node {{ node }}
create_zookeeper_dir_{{ node }}:
  file.directory:
    - name: /tmp/zookeeper/{{ node }}
    - makedirs: True
    - user: root
    - group: root
    - mode: 755

# Manage myid file for Zookeeper node {{ node }}
create_myid_file_{{ node }}:
  file.managed:
    - name: /tmp/zookeeper/{{ node }}/myid
    - contents: '{{ zk_id }}'
    - user: root
    - group: root
    - mode: 644
{% endif %}
