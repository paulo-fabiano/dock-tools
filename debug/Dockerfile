FROM alpine:3.23.2

RUN addgroup -S debug && adduser -S debug -G debug

RUN apk add --no-cache \
        curl \
        git \
        jq \
        vim

CMD [ "sleep", "infinity" ]