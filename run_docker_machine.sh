#!/bin/bash

# function for running a VM
run() {
    echo "Launching VM.."
    docker-machine -D create \
        --driver amazonec2 \
        --amazonec2-region us-west-2 \
        --amazonec2-instance-type "t2.micro" \
        --amazonec2-ssh-keypath ~/.ssh/id_rsa \
        --amazonec2-access-key $AWS_ACCESS_KEY_ID \
        --amazonec2-secret-key $AWS_SECRET_ACCESS_KEY \
        nginx-lua-instance

     echo "Installing Jenkins.."
     docker-machine ssh nginx-lua-instance sudo docker run --name jenkins-dind --privileged -p 8080:8080 -d -v /home/ubuntu/jenkins:/var/lib/jenkins esboych/docker-jenkins-dind
     host_ip=$(docker-machine ip nginx-lua-instance)
     admin_pass=$(docker-machine ssh nginx-lua-instance sudo docker exec jenkins-dind cat /var/lib/jenkins/secrets/initialAdminPassword)
     printf "The aws instance is launched and Jenkins is available at: %s:8080\n" "$host_ip"
     printf "One-time Jenkins password is: %s\n" "$admin_pass"
     printf "Webhook url for GitHub repo : \nhttp//:%s:8080/github-webhook/\n" "$host_ip"
}

# function for stopping a VM
stop() {
    echo "Stopping VM:"
    docker-machine stop nginx-lua-instance
    docker-machine rm -y nginx-lua-instance
}

# Either run or stop aws instance based on cli arguments
if [[ $1 == run ]]; then
    run
elif [[ $1 == stop ]]; then
    stop
else
    echo "Command format: run_docker_machine.sh run | stop"

fi