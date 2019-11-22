FROM lierdakil/alpine-haskell-gmp:8.6.5
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && apk --no-cache --update add git upx cabal llvm zlib-dev

WORKDIR /root

COPY ./cabal.project.local ./
COPY ./pandoc-crossref.cabal ./

ENV PANDOC_VER --constraint=pandoc==2.7.3
RUN cabal new-update
RUN cabal new-build pandoc $PANDOC_VER --jobs

RUN cabal new-build --only-dependencies $PANDOC_VER --jobs
