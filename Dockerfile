FROM lierdakil/alpine-haskell-gmp:8.8.3
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && apk --no-cache --update add git upx zlib-dev zlib-static

WORKDIR /root

COPY ./cabal.project.local ./
COPY ./pandoc-crossref.cabal ./

ENV PANDOC_VER --constraint=pandoc==2.9.2.1
RUN cabal v2-update
RUN cabal v2-build pandoc $PANDOC_VER --jobs
RUN cabal v2-build --only-dependencies $PANDOC_VER --jobs --enable-tests
