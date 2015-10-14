clone git repo:
  git.latest:
      - name: https://github.com/devopsjedi/hadoop-docker-jmx_exporter
      - target: /home/vagrant/hadoop-docker-jmx_exporter
      - branch: master

docker pull sequenceiq/hadoop-docker_2.7.0:
  docker.pulled:
    - name: sequenceiq/hadoop-docker
    - tag: 2.7.0

docker build hadoop-docker-jmx_exporter:
  docker.built:
    - path: /home/vagrant/hadoop-docker-jmx_exporter
    - name: devopsjedi/hadoop
    - require:
      - docker: sequenceiq/hadoop-docker
      
docker run hadoop:
  docker.running:
    - name: hadoop
    - image: devopsjedi/hadoop
    - ports:
      - "8088/tcp":
          HostIp: ""
          HostPort: "8088"
    - tty: True
    - command: "/etc/bootstrap.sh -bash"


