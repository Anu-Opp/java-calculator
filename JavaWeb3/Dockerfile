# Use Tomcat base image with Java 17
FROM tomcat:9.0-jdk17-temurin

# Remove default webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy built WAR into Tomcat's deployment directory
COPY target/WebAppCal-0.0.6.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

