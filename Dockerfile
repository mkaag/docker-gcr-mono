FROM sameersbn/gitlab-ci-runner:latest

MAINTAINER Maurice Kaag <mkaag@me.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN \
    apt-get update -qqy; \
    apt-get install -qqy curl; \
    curl -s http://download.mono-project.com/repo/xamarin.gpg | apt-key add - ; \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/xamarin.list; \
    apt-get update -qqy; \
    apt-get install -qqy mono-complete; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mozroots --import --sync --machine && echo "y\n\y\n" | certmgr -ssl -m https://nuget.org
