ARG RUBY_IMAGE_TYPE='ruby'

FROM $RUBY_IMAGE_TYPE:3.1.2-alpine
ARG APP_HOME=/app

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
RUN apk add --update alpine-sdk

ENV BUNDLE_PATH=/gems \
    BUNDLE_BIN=/gems/bin \
    GEM_HOME=/gems
ENV PATH /gems/bin:$PATH

COPY . $APP_HOME
