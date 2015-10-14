include: [ hadoop_docker]

pull prom/prometheus:
  docker.pulled:
    - name: prom/prometheus


docker run prometheus:
  docker.running:
    - name: prometheus
    - image: prom/prometheus
    - links:
        hadoop: hadoop
    - ports:
      - "9090/tcp":
            HostIp: ""
            HostPort: "9090"
    - volumes:
      - "/home/vagrant/hadoop-docker-jmx_exporter/example_prometheus.yml:/etc/prometheus/prometheus.yml"
    - requires:
      - hadoop_docker:
        - git.latest
        - dockerio.running
      - docker.pulled

