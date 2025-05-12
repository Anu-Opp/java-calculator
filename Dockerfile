# Stage 1: Build the Java app
FROM maven:3.9.6-eclipse-temurin-17 as builder
WORKDIR /build

# Copy only your app (JavaWeb3 folder)
COPY JavaWeb3/pom.xml .
COPY JavaWeb3/src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Stage 2: Create minimal JDK image to run the app
FROM openjdk:17
WORKDIR /app

# Copy the jar from the build stage
COPY --from=builder /build/target/*.jar app.jar

# Run the jar
CMD ["java", "-jar", "app.jar"]

