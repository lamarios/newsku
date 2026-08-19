FROM ibm-semeru-runtimes:open-25-jre

RUN mkdir /app

COPY ./target/newsku-*.jar  /app/newsku.jar

ADD ./docker/run.sh /run.sh

EXPOSE 8080

RUN chmod +x /run.sh

CMD "./run.sh"

HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
