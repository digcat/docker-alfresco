FROM marsbard/base
RUN apt-get update && apt-get -y --no-install-recommends install supervisor
RUN apt-get -y install python-dev python-requests 
RUN  mkdir /root/cmistool
COPY files/cmistool/cmisxcopy.cfg /root/cmistool/cmisxcopy.cfg
COPY files/cmistool/CmisXcopy.py /root/cmistool/CmisXcopy.py
COPY files/cmistool/gethavens.py /root/cmistool/gethavens.py
COPY files/cmistool/install_packages.sh /root/cmistool/install_packages.sh
COPY files/cmistool/keywords.py /root/cmistool/keywords.py
COPY files/cmistool/obo.py /root/cmistool/obo.py
COPY files/cmistool/organisepdf.py /root/cmistool/organisepdf.py
COPY files/cmistool/pictures /root/cmistool/pictures
COPY files/cmistool/run1st.py /root/cmistool/run1st.py
COPY files/cmistool/run2nd.sh /root/cmistool/run2nd.sh
COPY files/cmistool/testpics.sh /root/cmistool/testpics.sh
COPY files/cmistool/tika_obo.py /root/cmistool/tika_obo.py


RUN easy_install cmislib
RUN cd /root && git clone https://github.com/erny/cmislib-alfresco-extension.git && cd cmislib-alfresco-extension && python setup.py install
RUN pip install beautifulsoup4
RUN pip install IPTCInfo
RUN pip install exifread
RUN pip install parallel_sync
RUN pip install tika
RUN mkdir -p /var/log/supervisor 

ADD files/supervisor.conf /etc/supervisor/conf.d/supervisor.conf 
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
EXPOSE 8999 
CMD ["/usr/bin/supervisord"] 
