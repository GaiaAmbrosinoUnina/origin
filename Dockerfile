FROM ubuntu:16.04

RUN apt-get update -q
#COPY /tmp .
#ENV LOG_FILE /tmp/prova.txt
#RUN mkdir /cartellaprova
#RUN echo "prova" > /tmp/prova.txt
ADD ./sbin /usr/local/sbin
RUN apt-get install time -y
CMD ["/usr/local/sbin/simple-container-benchmarks-init"]
