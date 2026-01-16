FROM docker:rc-dind

RUN apk add --no-cache \
        curl

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.68.2

RUN mkdir -p /etc/trivy/templates

COPY trivy/templates/html.tpl /etc/trivy/templates/html.tpl

RUN addgroup -S ci && adduser -S ci -G ci

RUN chown ci:ci /etc/trivy/templates/html.tpl

USER ci