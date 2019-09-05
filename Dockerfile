FROM ubuntu:14.04
# install node and some other items
RUN apt-get update -q
#RUN apt-get update -y
RUN apt-get upgrade -y
#RUN apt-get update -y

RUN apt-get install -qy curl iperf ssh htop apt-utils nvm
RUN command -v node >/dev/null 2>&1 || { ln -s /usr/bin/nodejs /usr/bin/node; }

#RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN apt-get update && apt-get install -y -q --no-install-recommends \
apt-transport-https \
build-essential \
ca-certificates \
curl \
git \
libssl-dev \
wget

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.3

WORKDIR $NVM_DIR

RUN curl  [https://raw.githubusercontent.com/creationix/nvm/m…](https://raw.githubusercontent.com/creationix/nvm/master/install.sh)  | bash \
&& . $NVM_DIR/nvm.sh \
&& nvm install $NODE_VERSION \
&& nvm alias default $NODE_VERSION \
&& nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH







#RUN nvm install v10.16
RUN npm config set strict-ssl false

# the node dependencies for our node server app
# using caching suggestions per http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ADD ./server/package.json /tmp/package.json
RUN cd /tmp && npm install

# put the shell scripts in place
ADD ./sbin /usr/local/sbin

# our node server app
ADD ./server /server
RUN cp -r /tmp/node_modules /server/.

# expose port 80 for the node server
EXPOSE 80 5001
RUN chmod -R 777 /usr/
RUN chmod -R 777 /tmp/
RUN chmod -R 777 /server/
RUN chmod +rx /usr/local/sbin/simple-container-benchmarks-init
RUN chmod +rx /usr/local/sbin/simple-container-benchmarks
CMD ["/usr/local/sbin/simple-container-benchmarks-init"]
