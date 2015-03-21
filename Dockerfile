FROM ubuntu:14.04
MAINTAINER Shoichi Kaji <skaji@cpan.org>

# Usage:
# [local] $ docker build -t skaji/youtube .
# [local] $ docker run -p 5000:5000 -i -t skaji/youtube bash -l
# [docker]# perl get-youtube-audio VIDEO_ID
# [docker]# plackup -MPlack::App::Directory -e 'Plack::MIME->add_type(".m4a" => "audio/aac"); Plack::App::Directory->new->to_app'

ENV DEBIAN_FRONTEND=noninteractive

RUN rm /etc/apt/sources.list
RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' >> /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y \
  build-essential man wget tar git bzip2 vim lsof sudo zsh curl libssl-dev

RUN apt-get install -y gpac
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:mc3man/trusty-media
RUN apt-get update -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y ffmpeg
RUN apt-get clean -y

WORKDIR /root
RUN wget -q https://github.com/shoichikaji/relocatable-perl/releases/download/0.10/perl-x86_64-linux.tar.gz
RUN tar xf perl-x86_64-linux.tar.gz
RUN mv perl-x86_64-linux perl
RUN rm perl-x86_64-linux.tar.gz

COPY . .
RUN /root/perl/bin/cpanm -nq --installdeps .
RUN /root/perl/bin/cpanm -nq Plack

RUN echo 'export PATH=/root/perl/bin:$PATH' >> /root/.bashrc
EXPOSE 5000
