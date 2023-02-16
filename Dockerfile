FROM ubuntu:16.04
WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive
ADD bash.sh /app/bash.sh
RUN apt-get update
CMD ["/bin/bash", "/app/bash.sh"]
