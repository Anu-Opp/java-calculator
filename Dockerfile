# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /build

# Copy the full Java project
COPY JavaWeb3/ .

# Build the .jar file
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:17
WORKDIR /app

# Copy built .jar into final image
COPY --from=builder /build/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]

