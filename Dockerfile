# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 as builder
WORKDIR /build
COPY JavaWeb3/ /build
RUN mvn clean package -f pom.xml

# Stage 2: Run the app
FROM openjdk:17
WORKDIR /app
COPY --from=builder /build/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

