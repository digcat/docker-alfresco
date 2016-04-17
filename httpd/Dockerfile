FROM httpd:2.4

VOLUME /data

RUN apt-get update && apt-get -y install openssl && apt-get -y install apache2-utils 

COPY files/httpd.conf.tpl /tmp/httpd.conf.tpl

# thanks to http://stackoverflow.com/a/2916159/370191, luckily our slightly bloated ubuntu base already has perl
# this script replaces any "${}" templates with their equivalent value from the same named enviromnent variable
RUN perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < /tmp/httpd.conf.tpl > /usr/local/apache2/conf/httpd.conf
#RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load

RUN apt-get -y install libapache2-mod-security2

# remove conf file so our first run will generate it including templating the environment
RUN rm /usr/local/apache2/conf/httpd.conf
RUN apt-get -y install libapache2-mod-evasive

RUN mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
RUN mkdir -p /var/log/mod_evasive
RUN chown www-data:www-data /var/log/mod_evasive
RUN apt-get -y install rkhunter chkrootkit
RUN apt-get -y install logwatch

RUN mv /etc/cron.weekly/rkhunter /etc/cron.weekly/rkhunter_update
RUN mv /etc/cron.daily/rkhunter /etc/cron.weekly/rkhunter_run
RUN mv /etc/cron.daily/chkrootkit /etc/cron.weekly/
RUN mv /etc/cron.daily/00logwatch /etc/cron.weekly/

COPY files/httpd-foreground /usr/local/bin/httpd-foreground

COPY files/generate-certs.sh /generate-certs.sh

# we will copy these back in after mounting /etc/ssl externally
# and then generate the keys
RUN mv /etc/ssl /etc/ssl.orig
VOLUME /etc/ssl

EXPOSE 443
