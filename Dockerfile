############################################################################################
####  General system build for a dynamic dns update client. This will function for      ####
####  Google DNS, DynDNS, and more anything that is compatible with DDClient            ####
############################################################################################
##
## Set my base
FROM ubuntu
##
ARG DEBIAN_FRONTEND=noninteractive
##
VOLUME /etc
## Lets get DDClient Installed
RUN apt update && apt install -y ddclient
##
RUN mkdir /home/scripts
COPY entrypoint.sh /home/scripts/entrypoint.sh
RUN chmod 777 /home/scripts/entrypoint.sh
RUN touch /var/log/entrypoint.log && touch /var/log/ddclient.log
##
COPY ddclient.conf /etc/ddclient.conf
##
CMD /home/scripts/entrypoint.sh