FROM ubuntu:16.04

RUN apt-get update -q
RUN cd /mnt
RUN mkdir ciao
#COPY /tmp .
#ENV LOG_FILE /tmp/prova.txt
#RUN mkdir /cartellaprova
#RUN echo "prova" > /tmp/prova.txt
ADD ./sbin /usr/local/sbin
RUN apt-get install time -y
RUN chmod -R 777 /usr/
RUN chmod +x /usr/local/sbin/simple-container-benchmarks-init
#CMD ["/usr/local/sbin/simple-container-benchmarks-init"]
CMD ["/bin/sh"]
