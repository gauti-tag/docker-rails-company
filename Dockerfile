# version of ruby
FROM ruby:2.7-alpine3.15

# Author's email && name
LABEL maintainer_email="gautier.tiehoule@ngser.com"
LABEL maintainer_full_name="Tiehoule Aubin Gautier"
LABEL maintainer_phone_number="+2250708345891"

# Define Packages to install
ARG BUILD_PACKAGES="curl build-base libxml2-dev libxslt-dev imagemagick linux-headers"
ARG DEV_PACKAGES="postgresql-dev nodejs yarn tzdata"

# Define env variables
ENV BUNDLER_VERSION=2.0.2 \
  GEM_HOME="/home/ngser/bundle" \
  RAILS_ROOT="/home/ngser/app"

ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

# Execute the packages installation
RUN apk add --update --no-cache \
  $BUILD_PACKAGES $DEV_PACKAGES \
  && rm -rf /var/cache/apk/*


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Set the working directory of everything to the directory we just made.
RUN adduser -h /home/ngser -D ngser
USER ngser
RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT


# Copy the gemfile and gemfile.lock so we can run bundle on it
# Install and run bundle to get the app ready
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $BUNDLER_VERSION \
  && bundle config build.nokogiri --use-system-libraries
RUN bundle config set without 'test' \
  && bundle check || bundle install --jobs=3 --retry=3 \
  && bundle clean --force

#COPY package.json yarn.lock ./

# Install npm packages
RUN yarn install --check-files && yarn cache clean

# Copy the Rails application into place
COPY --chown=ngser . ./

# Add a script to be executed every time the container starts.
ENTRYPOINT ["sh", "entrypoint.sh"]

# Expose port 3000 on the container
EXPOSE 3000

# Clear cache (optional)
# RUN bundle exec rake tmp:clear

# Run the application on port 3000
CMD ["bundle", "exec", "puma"]