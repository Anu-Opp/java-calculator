# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /build

# Copy JavaWeb3 source (assumes Dockerfile is inside JavaWeb3/)
COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:17
WORKDIR /app

COPY --from=builder /build/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]

