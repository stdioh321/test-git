FROM node:14.18.1

RUN apt-get update
RUN apt-get install -y git

WORKDIR /apps

ARG SSH_PRIVATE_KEY
ARG SSH_PUBLIC_KEY
RUN echo $SSH_PASS


# make sure your domain is accepted
# RUN touch /root/.ssh/known_hosts
# RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config


RUN mkdir /root/.ssh/
RUN echo  "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN echo  "${SSH_PUBLIC_KEY}" > /root/.ssh/id_rsa.pub
RUN chmod 400 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
# RUN ssh-keyscan gitlab.com >> /root/.ssh/known_hosts
# RUN ssh-keyscan newwaycorp.io >> /root/.ssh/known_hosts
RUN ssh-keyscan git.newwaycorp.io >> /root/.ssh/known_hosts

# RUN --mount=type=ssh git clone git@git.newwaycorp.io:chatbots/builder4bots/flow-engine.git
CMD tail -f /dev/null