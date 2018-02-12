# Trying to inherit from jenkins/jenkins https://github.com/jenkinsci/docker/blob/master/Dockerfile
# and jenkins/dind https://github.com/mesosphere/dcos-jenkins-dind-agent/blob/master/Dockerfile.ubuntu
# to build docker images inside Jenkins Docker container

FROM jenkins/jenkins:lts

# Below is the snippet from https://github.com/mesosphere/dcos-jenkins-dind-agent/blob/master/Dockerfile.ubuntu :

# > SNIPPET START

# links to commit hashes are listed inside posted Dockerfiles https://hub.docker.com/r/library/docker/
# NOTE: must match engine version that is directly pulled from Alpine's Dockerfile
ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034
# docker
RUN curl -sSL https://get.docker.com | sh
# fetch DIND script
RUN curl -sSL https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind -o /usr/local/bin/dind \
    && chmod a+x /usr/local/bin/dind

COPY ./wrapper.sh /usr/local/bin/wrapper.sh
RUN chmod a+x /usr/local/bin/wrapper.sh

VOLUME /var/lib/docker

# < SNIPPET END

