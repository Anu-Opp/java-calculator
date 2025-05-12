# Stage 1: Build using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /build

# Copy source files
COPY JavaWeb3/pom.xml .
COPY JavaWeb3/src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Stage 2: Run with JDK
FROM openjdk:17
WORKDIR /app

# Copy built jar from stage 1
COPY --from=builder /build/target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]

