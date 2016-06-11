FROM ruby
RUN useradd -m -d /home/devel -s /bin/bash -c "the development user" -g users devel
RUN echo gem: --no-document >> /etc/gemrc
RUN gem update --system
RUN gem install bundler
RUN gem install rspec
RUN chown -R devel:users /usr/local
USER devel
RUN echo 'export PATH=/usr/local/bundle/bin:$PATH' >>/home/devel/.profile
VOLUME "/Code"
WORKDIR /Code

