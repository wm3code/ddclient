############################################################################################
####  General system build for a dynamic dns update client. This will function for      ####
####  Google DNS, DynDNS, and more anything that is compatible with DDClient            ####
############################################################################################
##
## Set my base
FROM ubuntu
##
## Lets Set Container Information as well as some basic arguments
## Label The System
### Labels That will Change
LABEL org.opencontainers.image.created="1/1/2022"
LABEL org.opencontainers.image.version="2022-01"
### Static Labels
LABEL org.opencontainers.image.authors="WM3 LLc Code Administrator"
LABEL org.opencontainers.image.url="https://www.wm3.biz"
LABEL org.opencontainers.image.documentation="https://github.com/wm3code/ddclient"
LABEL org.opencontainers.image.source="https://github.com/wm3code/ddclient"
LABEL org.opencontainers.image.vendor="WM3 LLc"
LABEL org.opencontainers.image.licenses="GPL v3 - See Ubuntu & DDClient Official Sites for their respective licensing"
LABEL org.opencontainers.image.title="Dynamic DNS Update Client"
LABEL org.opencontainers.image.description="Ubuntu Focal Base plus DDClient to have a DNS a record updated on a DHCP ISP Connection. Use your DNS Provider for configuration reference"
LABEL org.opencontainers.image.base.name="ubuntu"
## Tell ubuntu not to ask any questions
ARG DEBIAN_FRONTEND=noninteractive
## I cant expose a file in the docker build as a volume so this is just as well.
VOLUME /etc
## Lets get DDClient Installed
RUN apt update && apt install -y ddclient
## Copy the scripts needed to launch and log the system
RUN mkdir /home/scripts
COPY entrypoint.sh /home/scripts/entrypoint.sh
RUN chmod 777 /home/scripts/entrypoint.sh
RUN touch /var/log/entrypoint.log && touch /var/log/ddclient.log
## Copy DDClient config into the initial run this will need to be edited by the person running the container
COPY ddclient.conf /etc/ddclient.conf
## Lets do some clean up before we let everyone have fun
RUN apt -y autoremove
RUN apt clean
RUN apt-get autoremove --yes
## Yes this will most likely make APT brake but thats why I update this frequently. (once every 3 months so expect 4 a yr Jan. Apr. July & Oct unless Security Issues Arise)
## I suggest using Docker-Compose to run this setup so that you can maintain better version controls. Versions will be named wm3docker/ddclient:year-##
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/
## Lets get the party started
CMD /home/scripts/entrypoint.sh