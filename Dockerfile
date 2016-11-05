#
# Run/build server inside docker nodejs container
#

FROM node:5
MAINTAINER Inaki Anduaga <inaki@inakianduaga.com>

# Update npm to the latest version
#RUN npm install npm -g

# Install tsd typescript definitions manager
RUN npm install tsd -g

# Install pm2 globally
RUN npm install pm2 -g

WORKDIR /app
VOLUME /app

EXPOSE 8080

ENTRYPOINT ["node", "./node_modules/gulp/bin/gulp.js"]
CMD ["--help"]

# Disable gulp-notify notifications
ENV DISABLE_NOTIFIER=true

# enable color in terminal
ENV TERM=xterm-256color
