FROM openfaas/of-watchdog:0.7.1 as watchdog

FROM ubuntu:18.04
#ARG ADDITIONAL_PKG=""

#RUN apk add --no-cache ${ADDITIONAL_PKG}

#Install aeneas
WORKDIR /root

RUN \
    apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    libtool \
    time \
    bc \
    python \
    python-pip \
    git \
    curl \
    mosquitto-clients

RUN \
    apt-get install -y \
    wget 
    
RUN \
    pip install boto3   

RUN \
    git init && \
    git remote add -f origin https://github.com/qub-blesson/DeFog.git && \
    git config core.sparsecheckout true && \
    echo Aeneas/aeneas/ >> .git/info/sparse-checkout && \
    git pull https://github.com/qub-blesson/DeFog.git master
    
RUN \
    cd Aeneas/aeneas && \
    bash install_dependencies.sh && \
    pip install -r requirements.txt && \
    python setup.py build_ext --inplace

RUN pip install aeneas

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

#RUN addgroup -S app && adduser app -S -G app

RUN addgroup --system app && adduser app --system --ingroup app

WORKDIR /root/

RUN mkdir -p /home/app

# Wrapper/boot-strapper
WORKDIR /home/app
COPY index.sh ./

WORKDIR /home/app/function
COPY function/*.sh ./
COPY function/p001.txt  /tmp

# Copy in additional function files and folders
COPY --chown=app:app function/ .

WORKDIR /home/app/

# chmod for tmp is for a buildkit issue (@alexellis)
RUN chmod +rx -R ./function \
    && chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

ENV mode="streaming"

ENV fprocess="bash ./index.sh"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
