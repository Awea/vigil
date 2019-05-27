# Inspired by: https://gist.github.com/sarat1669/d34dc34a07e6df03095b779df03327c7

FROM ubuntu:18.04

RUN \
  apt-get update && \
  apt-get install -y wget curl gnupg

RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install -y esl-erlang build-essential openssh-server git locales unzip autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev

# Install asdf
RUN \
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
  cd ~/.asdf && git checkout "$(git describe --abbrev=0 --tags)"
ENV PATH="${PATH}:/asdf/.asdf/shims:/asdf/.asdf/bin"
ENV PATH /root/.asdf/bin:/root/.asdf/shims:$PATH
RUN echo '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
RUN echo '\n. $HOME/.asdf/asdf.sh' >> ~/.profile

# Install and setup given Elixir version
ARG elixir_version
RUN asdf plugin-add elixir
RUN asdf install elixir ${elixir_version}
RUN asdf global elixir ${elixir_version}

## Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=$LANG

## Setup hex
RUN mix local.hex --force
RUN mix local.rebar --force

# Config ssh
RUN mkdir /var/run/sshd
COPY config/id_rsa.pub /root/.ssh/authorized_keys
RUN  echo "AuthorizedKeysFile  %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
