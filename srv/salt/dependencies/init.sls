configure docker api version:
  file.managed:
    - name: /etc/salt/minion.d/docker.conf
    - source: salt://config/docker.conf    

install pip:
  pkg.installed:
    - name: python-pip

install docker-py:
  pip.installed:
    - name: docker-py ==1.2.3
    - require:
      - pkg: python-pip
    - reload_modules: true

add docker prerequisite for aufs support:
  pkg.installed:
    - name: {{ 'linux-image-extra-' ~ grains['kernelrelease'] }}

add docker managed repo:
  pkgrepo.managed:
    - humanname: Docker managed package repository
    - name:  deb https://get.docker.com/ubuntu docker main
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - require:
      - pkg: {{ 'linux-image-extra-' ~ grains['kernelrelease'] }}

install docker:
  pkg.installed:
    - name: lxc-docker
    - require:
      - pkgrepo: deb https://get.docker.com/ubuntu docker main

