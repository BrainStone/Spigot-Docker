# ----------------------------------
# Spigot-Docker Dockerfile
# All Minecraft versions are prebuilt.
# ----------------------------------
FROM frolvlad/alpine-oraclejdk8:cleaned

MAINTAINER BrainStone

RUN apk update && \
    apk add curl git && \
    curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar; \
    for MC_VERSION in $( \
      curl -s https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | \
      grep -o "[[:digit:]]\.[0-9]*\.[0-9]" | \
      sort -ut. -k 1,1nr -k 2,2nr -k 3,3nr
    );  \
    do \
      java -jar BuildTools.jar --rev $MC_VERSION; \
    done && \
    rm BuildTools.log.txt
