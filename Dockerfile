FROM ruby:3.1.2-alpine as runner

RUN apk add --update --no-cache build-base \
  git \
  nodejs \
  tzdata \
  imagemagick \
  libxml2-dev \
  libxslt-dev \
  libpq \
  gcompat \
  libjemalloc1

ENV APP_ROOT_PATH=/home/snap \
  GEM_HOME=/home/snap/vendor/bundle \
  GEM_PATH=/usr/local/bundle:/home/snap/vendor/bundle \
  BUNDLE_APP_CONFIG=/home/snap/vendor/bundle \
  MALLOC_ARENA_MAX=2 \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  TZ=Europe/Paris \
  editor=vim \
  HISTFILE=.shell_history \
  LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1

WORKDIR /home/snap

RUN addgroup -S snap && adduser -S snap -G snap
RUN chown -R snap:snap /home/snap
USER snap

COPY --chown=snap . /home/snap

RUN gem install bundler -v 2.3.20 --no-document
RUN bundle check || bundle install --jobs 5 --retry 5 \
  && bundle clean --force
