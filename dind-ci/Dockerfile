FROM docker:rc-dind

RUN apk add --no-cache \
        curl

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.68.2

RUN mkdir -p /etc/trivy/templates

COPY trivy/templates/html.tpl /etc/trivy/templates/html.tpl

ENTRYPOINT ["unset DOCKER_HOST", "&", "dockerd"]