# Use official Tomcat base image
FROM tomcat:9-jdk17

# Remove default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to Tomcat's deployment directory
COPY JavaWeb3/target/WebAppCal-0.0.6.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat (already CMD by default)

