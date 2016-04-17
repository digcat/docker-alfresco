docker run -d --name alf_datamart --dns 172.17.0.3 --dns 8.8.8.8 --link alf_tika --link alf_alfresco --link alf_share alf/datamart
