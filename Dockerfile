FROM openjdk:17
WORKDIR /app
COPY . .
RUN javac JavaWeb3/Calculator.java
CMD ["java", "JavaWeb3.Calculator"]
EXPOSE 8080

