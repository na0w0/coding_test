FROM mysql:latest

ARG UID=1000
ARG GID=1000

RUN groupmod -g $GID mysql && usermod -u $UID -g $GID mysql
