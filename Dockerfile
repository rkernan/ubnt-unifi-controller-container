FROM debian
MAINTAINER rkernan@gmail.com
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > /etc/apt/sources.list.d/100-ubnt.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
RUN apt-get -q --assume-no update && apt-get install -qy mongodb-server unifi
VOLUME /usr/lib/unifi/data
WORKDIR /usr/lib/unifi
EXPOSE 8080 8443 8880 8843
CMD ["java", "-Xmx256M", "-jar", "lib/ace.jar", "start"]
