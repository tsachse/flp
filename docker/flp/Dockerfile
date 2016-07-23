FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime --> rails
RUN apt-get install -y nodejs

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

