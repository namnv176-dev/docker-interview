FROM ubuntu:latest
WORKDIR /app
ADD bash.sh /app/bash.sh
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install cron
RUN ["chmod", "0644","/app/bash.sh"]
RUN crontab -l | { cat; echo "* * * * * bash  /app/bash.sh"; } | crontab -
RUN crontab -l | { cat; echo "* * * * * (sleep 30; bash  /app/bash.sh)"; } | crontab -
RUN ["touch", "/var/log/time.log"]
RUN ["chmod","+777", "/var/log/time.log"]
CMD cron
