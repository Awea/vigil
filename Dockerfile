# Inspired by: https://gist.github.com/sarat1669/d34dc34a07e6df03095b779df03327c7

FROM ubuntu:18.04

RUN \
  apt-get update && \
  apt-get install -y wget curl gnupg

RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install -y esl-erlang elixir build-essential openssh-server git locales

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=$LANG

RUN mkdir /var/run/sshd

# Create Builder user
RUN useradd --system --shell=/bin/bash --create-home builder

#config builder user for public key authentication
RUN mkdir /home/builder/.ssh/ && chmod 700 /home/builder/.ssh/
COPY config/id_rsa.pub /home/builder/.ssh/authorized_keys
RUN chown -R builder /home/builder/
RUN chgrp -R builder /home/builder/
RUN chmod 700 /home/builder/.ssh/
RUN chmod 644 /home/builder/.ssh/authorized_keys

RUN mix local.hex
RUN mix local.rebar

RUN  echo "AuthorizedKeysFile  %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
