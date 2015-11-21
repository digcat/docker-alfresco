cd "`dirname $0`"
mkdir files/tmp/keystore -p

wget -c -O files/tmp/alfresco.war https://artifacts.alfresco.com/nexus/service/local/repo_groups/public/content/org/alfresco/alfresco/5.0.d/alfresco-5.0.d.war

wget -c https://jdbc.postgresql.org/download/postgresql-9.4-1205.jdbc42.jar -O files/tmp/postgresql.jdbc.jar

wget -c -O files/tmp/mysql.jdbc.zip http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.37.zip
pushd files/tmp
unzip mysql.jdbc.zip  mysql-connector-java-5.1.37/mysql-connector-java-5.1.37-bin.jar
cp mysql-connector-java-5.1.37/mysql-connector-java-5.1.37-bin.jar ./mysql.jdbc.jar
rm -rf mysql-connector-java-5.1.37
popd


for file in browser.p12 generate_keystores.sh keystore keystore-passwords.properties \
	ssl-keystore-passwords.properties ssl-truststore-passwords.properties ssl.keystore ssl.truststore
do
  wget -c -O files/tmp/keystore/$file http://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/$file
done

