FROM alpine:latest
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && apk --no-cache --update add musl-dev gmp-dev zlib-dev pcre-dev libc-dev ncurses-dev pcre-dev llvm clang ghc cabal curl git upx

RUN cabal update
RUN cabal install cabal-install
ENV PATH=/root/.cabal/bin:$PATH

WORKDIR /root

COPY ./cabal.project.local ./
COPY ./pandoc-crossref.cabal ./

RUN cabal new-update
RUN cabal new-build --only-dependencies --jobs
