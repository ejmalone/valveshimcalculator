FROM ruby:2.7.6 as shims-development

# Expose when running Dockerfile alone
ENV USER_ID 1000
ENV GROUP_ID 1000

# Create a user with the same ID and GID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends esbuild nodejs npm yarn

COPY . .
RUN yarn install
RUN bundle install

EXPOSE 3000

CMD ["./bin/dev"]
